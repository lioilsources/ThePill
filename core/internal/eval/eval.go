// Package eval měří model na ručně označeném setu (data/eval/*.jsonl).
//
// Cíle z plánu (fáze 1a):
//   - /soften: žádný ztracený fakt (tvrdá metrika, blokuje build)
//   - /classify: hostile recall ≥ 85 %
//   - /classify: false positives na neutrálních ≤ 5 %
package eval

import (
	"bufio"
	"context"
	"encoding/json"
	"fmt"
	"io"
	"os"
	"strings"

	"github.com/lioilsources/ThePill/core/internal/api"
	"github.com/lioilsources/ThePill/core/internal/model"
)

const (
	MinHostileRecall = 0.85
	MaxNeutralFP     = 0.05
)

// Item = jeden řádek eval setu. Formát popisuje data/eval/README.md.
type Item struct {
	ID       string     `json:"id,omitempty"`
	Text     string     `json:"text"`
	Tone     model.Tone `json:"tone"`
	TextSoft string     `json:"text_soft,omitempty"`
	Facts    []string   `json:"facts,omitempty"`
}

func Load(path string) ([]Item, error) {
	f, err := os.Open(path)
	if err != nil {
		return nil, err
	}
	defer f.Close()
	return Parse(f)
}

func Parse(r io.Reader) ([]Item, error) {
	var items []Item
	sc := bufio.NewScanner(r)
	sc.Buffer(make([]byte, 64<<10), 1<<20)
	line := 0
	for sc.Scan() {
		line++
		s := strings.TrimSpace(sc.Text())
		if s == "" || strings.HasPrefix(s, "//") {
			continue
		}
		var it Item
		if err := json.Unmarshal([]byte(s), &it); err != nil {
			return nil, fmt.Errorf("řádek %d: %w", line, err)
		}
		if it.Text == "" || !it.Tone.Valid() {
			return nil, fmt.Errorf("řádek %d: chybí text nebo neplatný tone %q", line, it.Tone)
		}
		if it.Tone.Sharp() && it.TextSoft == "" {
			return nil, fmt.Errorf("řádek %d: ostrá zpráva bez text_soft", line)
		}
		// Chyba v anotaci: referenční přepis sám neobsahuje fakt, který vyžadujeme.
		if miss := model.MissingFacts(it.Text, it.Facts); len(miss) > 0 {
			return nil, fmt.Errorf("řádek %d: fakta %v nejsou ani v originálu", line, miss)
		}
		if it.TextSoft != "" {
			facts := append(append([]string{}, it.Facts...), model.HardFacts(it.Text)...)
			if miss := model.MissingFacts(it.TextSoft, facts); len(miss) > 0 {
				return nil, fmt.Errorf("řádek %d: text_soft neobsahuje fakta %v", line, miss)
			}
		}
		if it.ID == "" {
			it.ID = fmt.Sprintf("L%d", line)
		}
		items = append(items, it)
	}
	return items, sc.Err()
}

type Report struct {
	Total, Sharp, Neutral int

	// classify
	SharpCaught, NeutralFlagged int
	Confusion                   map[model.Tone]map[model.Tone]int // [gold][pred]

	// soften (jen ostré)
	Softened        int
	RawLostFacts    int      // model ztratil fakt (zachyceno pojistkou → fallback)
	FinalLostFacts  int      // fakt chybí i v tom, co uvidí uživatel — musí být 0
	Fallbacks       int      // vrácen originál místo přepisu
	LostFactDetails []string // "id: fakt"

	// coach
	CoachCaught, CoachNeutralFlagged int

	Degraded     int            // volání, kde model selhal (počítá se jako fail-open)
	DegradedKind map[string]int // "classify: model: neplatný výstup" → počet
	Misses       []string       // "id: gold→pred (score)" u špatně zařazených
	FallbackIDs  []string
}

func (r *Report) fail(endpoint string, err error) {
	r.Degraded++
	if r.DegradedKind == nil {
		r.DegradedKind = map[string]int{}
	}
	msg := err.Error()
	if len(msg) > 80 {
		msg = msg[:80]
	}
	r.DegradedKind[endpoint+": "+msg]++
}

func (r Report) HostileRecall() float64 { return ratio(r.SharpCaught, r.Sharp) }
func (r Report) NeutralFP() float64     { return ratio(r.NeutralFlagged, r.Neutral) }
func (r Report) CoachRecall() float64   { return ratio(r.CoachCaught, r.Sharp) }
func (r Report) CoachFP() float64       { return ratio(r.CoachNeutralFlagged, r.Neutral) }
func (r Report) FallbackRate() float64  { return ratio(r.Fallbacks, r.Softened) }

func ratio(a, b int) float64 {
	if b == 0 {
		return 0
	}
	return float64(a) / float64(b)
}

// Failures vrátí porušené cíle; prázdný set nic neporušuje.
func (r Report) Failures() []string {
	var f []string
	if r.FinalLostFacts > 0 {
		f = append(f, fmt.Sprintf("/soften ztratil %d faktů (cíl 0)", r.FinalLostFacts))
	}
	if r.Sharp > 0 && r.HostileRecall() < MinHostileRecall {
		f = append(f, fmt.Sprintf("hostile recall %.1f %% < %.0f %%", 100*r.HostileRecall(), 100*MinHostileRecall))
	}
	if r.Neutral > 0 && r.NeutralFP() > MaxNeutralFP {
		f = append(f, fmt.Sprintf("FP na neutrálních %.1f %% > %.0f %%", 100*r.NeutralFP(), 100*MaxNeutralFP))
	}
	return f
}

// Run projde set stejnou cestou jako server (včetně fail-open a pojistky faktů).
func Run(ctx context.Context, m model.Model, items []Item) Report {
	r := Report{Total: len(items), Confusion: map[model.Tone]map[model.Tone]int{}}
	for _, it := range items {
		sharp := it.Tone.Sharp()
		neutral := it.Tone == model.ToneOK
		if sharp {
			r.Sharp++
		}
		if neutral {
			r.Neutral++
		}

		c, err := m.Classify(ctx, model.ClassifyInput{Text: it.Text, Lang: "cs"})
		if err != nil {
			r.fail("classify", err)
			c.Tone = model.ToneOK // fail-open jako server
		}
		if r.Confusion[it.Tone] == nil {
			r.Confusion[it.Tone] = map[model.Tone]int{}
		}
		r.Confusion[it.Tone][c.Tone]++
		if it.Tone.Sharp() != c.Tone.Sharp() {
			r.Misses = append(r.Misses, fmt.Sprintf("%s: %s→%s (%.2f)", it.ID, it.Tone, c.Tone, c.Score))
		}
		if sharp && c.Tone.Sharp() {
			r.SharpCaught++
		}
		if neutral && c.Tone.Sharp() {
			r.NeutralFlagged++
		}

		co, err := m.Coach(ctx, it.Text, "cs")
		if err != nil {
			r.fail("coach", err)
		}
		if sharp && co.IsHostile {
			r.CoachCaught++
		}
		if neutral && co.IsHostile {
			r.CoachNeutralFlagged++
		}

		if !sharp {
			continue
		}
		r.Softened++
		facts := append(append([]string{}, it.Facts...), model.HardFacts(it.Text)...)
		s, err := m.Soften(ctx, it.Text, "cs")
		final := s
		if err != nil {
			r.fail("soften", err)
			final = model.Softened{TextSoft: it.Text}
			r.Fallbacks++
			r.FallbackIDs = append(r.FallbackIDs, it.ID+"(chyba)")
		} else {
			if len(model.MissingFacts(s.TextSoft, facts)) > 0 {
				r.RawLostFacts++
			}
			if !api.FactsPreserved(it.Text, s) {
				final = model.Softened{TextSoft: it.Text}
				r.Fallbacks++
				r.FallbackIDs = append(r.FallbackIDs, fmt.Sprintf("%s%v", it.ID, append(model.MissingFacts(s.TextSoft, model.HardFacts(it.Text)), model.MissingFactsFuzzy(s.TextSoft, s.KeptFacts)...)))
			}
		}
		for _, f := range model.MissingFacts(final.TextSoft, facts) {
			r.FinalLostFacts++
			r.LostFactDetails = append(r.LostFactDetails, it.ID+": "+f)
		}
	}
	return r
}

func (r Report) Print(w io.Writer) {
	fmt.Fprintf(w, "eval: %d zpráv (%d ostrých, %d neutrálních)\n", r.Total, r.Sharp, r.Neutral)
	if r.Total == 0 {
		fmt.Fprintln(w, "set je prázdný — doplň data/eval/eval.jsonl (formát v data/eval/README.md)")
		return
	}
	fmt.Fprintf(w, "classify  hostile recall %5.1f %%  (cíl ≥ %.0f %%)\n", 100*r.HostileRecall(), 100*MinHostileRecall)
	fmt.Fprintf(w, "classify  FP neutrální   %5.1f %%  (cíl ≤ %.0f %%)\n", 100*r.NeutralFP(), 100*MaxNeutralFP)
	fmt.Fprintf(w, "soften    ztracené fakty %d  (cíl 0), surově u %d zpráv, fallback %.1f %%\n",
		r.FinalLostFacts, r.RawLostFacts, 100*r.FallbackRate())
	fmt.Fprintf(w, "coach     recall %5.1f %%, FP %5.1f %%\n", 100*r.CoachRecall(), 100*r.CoachFP())
	if r.Degraded > 0 {
		fmt.Fprintf(w, "POZOR: %d volání modelu selhalo (fail-open)\n", r.Degraded)
		for k, n := range r.DegradedKind {
			fmt.Fprintf(w, "  %3d× %s\n", n, k)
		}
	}
	if len(r.Misses) > 0 {
		fmt.Fprintln(w, "špatně zařazené:", strings.Join(r.Misses, ", "))
	}
	if len(r.FallbackIDs) > 0 {
		fmt.Fprintln(w, "fallback (chybějící fakta):", strings.Join(r.FallbackIDs, ", "))
	}
	tones := []model.Tone{model.ToneOK, model.ToneTense, model.ToneHostile, model.ToneManipulative}
	fmt.Fprintf(w, "\nconfusion (řádek = zlatý tón, sloupec = predikce)\n%-13s", "")
	for _, t := range tones {
		fmt.Fprintf(w, "%13s", t)
	}
	fmt.Fprintln(w)
	for _, g := range tones {
		fmt.Fprintf(w, "%-13s", g)
		for _, p := range tones {
			fmt.Fprintf(w, "%13d", r.Confusion[g][p])
		}
		fmt.Fprintln(w)
	}
	for _, d := range r.LostFactDetails {
		fmt.Fprintln(w, "ztracený fakt —", d)
	}
}
