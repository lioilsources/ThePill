// Package api je HTTP vrstva pill-core.
//
// Pojistky z plánu (fáze 3), které platí tady:
//   - model offline / nesmyslný výstup → fail-open: propustit, nikdy tiše blokovat,
//     odpověď nese "degraded": true, aby klient mohl ukázat varování;
//   - /soften nesmí ztratit fakt → při podezření vrací originál ("fallback": true);
//   - text zpráv se nikdy neloguje, jen metriky (expvar na /debug/vars).
package api

import (
	"context"
	"crypto/subtle"
	"encoding/json"
	"errors"
	"expvar"
	"log/slog"
	"net/http"
	"strings"
	"time"
	"unicode/utf8"

	"github.com/lioilsources/ThePill/core/internal/model"
)

const maxTextRunes = 4000

var (
	mRequests = expvar.NewMap("pill_requests")        // per endpoint
	mDegraded = expvar.NewMap("pill_degraded")        // model nedostupný / špatný výstup
	mFallback = expvar.NewInt("pill_soften_fallback") // fact guard vrátil originál
	mTone     = expvar.NewMap("pill_tone")            // rozložení tónů z /classify
	mHostile  = expvar.NewInt("pill_coach_hostile")
)

type Server struct {
	Model   model.Model
	Timeout time.Duration
	// Token, when set, is required as "Authorization: Bearer <token>" on every
	// endpoint except /healthz (public deployment behind Caddy).
	Token string
}

func (s *Server) Handler() http.Handler {
	mux := http.NewServeMux()
	mux.HandleFunc("POST /classify", s.classify)
	mux.HandleFunc("POST /soften", s.soften)
	mux.HandleFunc("POST /coach", s.coach)
	mux.HandleFunc("GET /healthz", func(w http.ResponseWriter, _ *http.Request) { w.Write([]byte("ok\n")) })
	mux.Handle("GET /debug/vars", expvar.Handler())
	return logRequests(s.auth(mux))
}

func (s *Server) auth(next http.Handler) http.Handler {
	if s.Token == "" {
		return next
	}
	want := []byte("Bearer " + s.Token)
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path != "/healthz" && subtle.ConstantTimeCompare([]byte(r.Header.Get("Authorization")), want) != 1 {
			http.Error(w, "unauthorized", http.StatusUnauthorized)
			return
		}
		next.ServeHTTP(w, r)
	})
}

type textReq struct {
	Text    string `json:"text"`
	Sender  string `json:"sender,omitempty"`
	Channel string `json:"channel,omitempty"`
	Lang    string `json:"lang,omitempty"`
}

type classifyResp struct {
	model.Classification
	Degraded bool `json:"degraded,omitempty"`
}

type softenResp struct {
	model.Softened
	Fallback bool `json:"fallback,omitempty"`
	Degraded bool `json:"degraded,omitempty"`
}

type coachResp struct {
	model.Coaching
	Degraded bool `json:"degraded,omitempty"`
}

func (s *Server) ctx(r *http.Request) (context.Context, context.CancelFunc) {
	t := s.Timeout
	if t == 0 {
		t = 20 * time.Second
	}
	return context.WithTimeout(r.Context(), t)
}

func (s *Server) classify(w http.ResponseWriter, r *http.Request) {
	mRequests.Add("classify", 1)
	in, ok := decode(w, r)
	if !ok {
		return
	}
	ctx, cancel := s.ctx(r)
	defer cancel()
	c, err := s.Model.Classify(ctx, model.ClassifyInput{Text: in.Text, Sender: in.Sender, Channel: in.Channel, Lang: in.Lang})
	if err != nil {
		degraded("classify", err)
		writeJSON(w, classifyResp{
			Classification: model.Classification{Tone: model.ToneOK, Score: 0, Reason: "model nedostupný — propuštěno"},
			Degraded:       true,
		})
		return
	}
	mTone.Add(string(c.Tone), 1)
	writeJSON(w, classifyResp{Classification: c})
}

func (s *Server) soften(w http.ResponseWriter, r *http.Request) {
	mRequests.Add("soften", 1)
	in, ok := decode(w, r)
	if !ok {
		return
	}
	original := model.Softened{TextSoft: in.Text, KeptFacts: []string{}}
	ctx, cancel := s.ctx(r)
	defer cancel()
	out, err := s.Model.Soften(ctx, in.Text, in.Lang)
	if err != nil {
		degraded("soften", err)
		writeJSON(w, softenResp{Softened: original, Fallback: true, Degraded: true})
		return
	}
	if !FactsPreserved(in.Text, out) {
		mFallback.Add(1)
		writeJSON(w, softenResp{Softened: original, Fallback: true})
		return
	}
	writeJSON(w, softenResp{Softened: out})
}

// FactsPreserved: všechna čísla/časy originálu i všechna fakta, která model
// sám deklaroval, musí být v přepisu. Jinak radši originál.
func FactsPreserved(original string, out model.Softened) bool {
	if len(model.MissingFacts(out.TextSoft, model.HardFacts(original))) > 0 {
		return false
	}
	return len(model.MissingFactsFuzzy(out.TextSoft, out.KeptFacts)) == 0
}

func (s *Server) coach(w http.ResponseWriter, r *http.Request) {
	mRequests.Add("coach", 1)
	in, ok := decode(w, r)
	if !ok {
		return
	}
	ctx, cancel := s.ctx(r)
	defer cancel()
	c, err := s.Model.Coach(ctx, in.Text, in.Lang)
	if err != nil {
		degraded("coach", err)
		// Kouč mlčí — pisatel odešle, co napsal. Nikdy neblokujeme.
		writeJSON(w, coachResp{Coaching: model.Coaching{Alternatives: []string{}}, Degraded: true})
		return
	}
	if c.IsHostile {
		mHostile.Add(1)
	}
	writeJSON(w, coachResp{Coaching: c})
}

func decode(w http.ResponseWriter, r *http.Request) (textReq, bool) {
	var in textReq
	dec := json.NewDecoder(http.MaxBytesReader(w, r.Body, 64<<10))
	if err := dec.Decode(&in); err != nil {
		http.Error(w, `{"error":"neplatný JSON"}`, http.StatusBadRequest)
		return in, false
	}
	in.Text = strings.TrimSpace(in.Text)
	if in.Text == "" {
		http.Error(w, `{"error":"chybí text"}`, http.StatusBadRequest)
		return in, false
	}
	if utf8.RuneCountInString(in.Text) > maxTextRunes {
		http.Error(w, `{"error":"text je moc dlouhý"}`, http.StatusRequestEntityTooLarge)
		return in, false
	}
	if in.Lang == "" {
		in.Lang = "cs"
	}
	return in, true
}

func degraded(endpoint string, err error) {
	kind := "error"
	switch {
	case errors.Is(err, model.ErrBadOutput):
		kind = "bad_output"
	case errors.Is(err, context.DeadlineExceeded):
		kind = "timeout"
	}
	mDegraded.Add(endpoint+"."+kind, 1)
	// Chyba neobsahuje text zprávy (viz model.LLM) — smí do logu.
	slog.Warn("degraded", "endpoint", endpoint, "kind", kind, "err", err)
}

func writeJSON(w http.ResponseWriter, v any) {
	w.Header().Set("Content-Type", "application/json; charset=utf-8")
	_ = json.NewEncoder(w).Encode(v)
}

type statusWriter struct {
	http.ResponseWriter
	status int
}

func (s *statusWriter) WriteHeader(code int) { s.status = code; s.ResponseWriter.WriteHeader(code) }

// logRequests loguje jen metodu, cestu, status a latenci — nikdy tělo.
func logRequests(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		start := time.Now()
		sw := &statusWriter{ResponseWriter: w, status: http.StatusOK}
		next.ServeHTTP(sw, r)
		slog.Info("request", "method", r.Method, "path", r.URL.Path, "status", sw.status, "dur", time.Since(start).Round(time.Millisecond))
	})
}
