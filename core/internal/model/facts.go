package model

import (
	"regexp"
	"strings"
)

// Pojistka „/soften nikdy nemění fakta": deterministická kontrola nad výstupem
// modelu. Neodhalí všechno (fakt vyjádřený slovy), ale čísla, časy, data a
// částky musí v přepisu zůstat vždy — to je nejčastější ztráta.

var numRe = regexp.MustCompile(`\d+(?:[:.,/]\d+)*`)

// Kmeny časových slov (po Normalize). „včera" schválně ne — bývá součástí výčitky, ne termínu. „dnes" pokryje i „dneska", „zitr" i „zítřek".
var timeStems = []string{"dnes", "zitr", "pozitr", "rano", "vecer", "odpoledn", "dopoledn"}

var wordRe = regexp.MustCompile(`[\p{L}]+`)

// HardFacts vrátí fragmenty originálu, které přepis musí obsahovat vždy:
// čísla (časy, data, částky) a časová slova (dnes, zítra, ráno…).
func HardFacts(text string) []string {
	facts := numRe.FindAllString(text, -1)
	seen := map[string]bool{}
	for _, w := range wordRe.FindAllString(Normalize(text), -1) {
		for _, st := range timeStems {
			if strings.HasPrefix(w, st) && !seen[st] {
				seen[st] = true
				facts = append(facts, st)
			}
		}
	}
	return facts
}

// Normalize: malá písmena, bez diakritiky, sjednocené mezery.
func Normalize(s string) string {
	return strings.Join(strings.Fields(deaccent.Replace(strings.ToLower(s))), " ")
}

// Čeština + slovenština; víc jazyků zatím nepotřebujeme.
var deaccent = strings.NewReplacer(
	"á", "a", "č", "c", "ď", "d", "é", "e", "ě", "e", "í", "i", "ň", "n", "ó", "o",
	"ř", "r", "š", "s", "ť", "t", "ú", "u", "ů", "u", "ý", "y", "ž", "z",
	"ä", "a", "ĺ", "l", "ľ", "l", "ô", "o", "ŕ", "r", "ö", "o", "ü", "u",
)

// MissingFacts vrátí fakta, která v textu chybí (porovnání po Normalize).
func MissingFacts(text string, facts []string) []string {
	nt := Normalize(text)
	var missing []string
	for _, f := range facts {
		nf := Normalize(f)
		if nf == "" {
			continue
		}
		if !strings.Contains(nt, nf) {
			missing = append(missing, f)
		}
	}
	return missing
}

// MissingFactsFuzzy: jako MissingFacts, ale slovo faktu stačí najít podle kmene
// (bez posledních 1–2 písmen), aby skloňování a hovorové tvary („společnej" ×
// „společný", „mámu" × „mámě") nebyly ztrátou. Pro fakta, která deklaroval model.
func MissingFactsFuzzy(text string, facts []string) []string {
	words := wordRe.FindAllString(Normalize(text), -1)
	nums := Normalize(text)
	var missing []string
	for _, f := range facts {
		ok := true
		for _, w := range wordRe.FindAllString(Normalize(f), -1) {
			if !hasStem(words, stem(w)) {
				ok = false
				break
			}
		}
		for _, n := range numRe.FindAllString(f, -1) {
			if !strings.Contains(nums, n) {
				ok = false
			}
		}
		if !ok {
			missing = append(missing, f)
		}
	}
	return missing
}

func stem(w string) string {
	r := []rune(w)
	switch {
	case len(r) <= 3:
		return w
	case len(r) == 4:
		return string(r[:3])
	default:
		return string(r[:len(r)-2])
	}
}

func hasStem(words []string, st string) bool {
	for _, w := range words {
		if strings.HasPrefix(w, st) {
			return true
		}
	}
	return false
}
