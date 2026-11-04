package eval

import (
	"regexp"
	"strings"
	"testing"

	"github.com/lioilsources/ThePill/core/internal/model"
)

var wordRe = regexp.MustCompile(`[\p{L}\p{N}]+`)

// Few-shot příklady nesmí kopírovat dev set — jinak se měří na tom, co model viděl.
func TestNoPromptLeakIntoDevSet(t *testing.T) {
	items, err := Load("../../../data/dev/synthetic.jsonl")
	if err != nil {
		t.Fatal(err)
	}
	prompts := " " + strings.Join(wordRe.FindAllString(strings.ToLower(model.PromptText()), -1), " ") + " "
	for _, it := range items {
		w := wordRe.FindAllString(strings.ToLower(it.Text), -1)
		for i := 0; i+4 <= len(w); i++ {
			if g := " " + strings.Join(w[i:i+4], " ") + " "; strings.Contains(prompts, g) {
				t.Errorf("%s: %q je i v promptech", it.ID, strings.TrimSpace(g))
			}
		}
	}
}
