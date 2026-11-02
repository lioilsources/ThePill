package model

import (
	"regexp"
	"strings"
)

// Pojistka „/soften nikdy nemění fakta": deterministická kontrola nad výstupem
// modelu. Neodhalí všechno (fakt vyjádřený slovy), ale čísla, časy, data a
// částky musí v přepisu zůstat vždy — to je nejčastější ztráta.

var numRe = regexp.MustCompile(`\d+(?:[:.,/]\d+)*`)

// HardFacts vrátí číselné fragmenty originálu (časy, data, částky, čísla).
func HardFacts(text string) []string {
	return numRe.FindAllString(text, -1)
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
