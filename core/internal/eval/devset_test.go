package eval

import "testing"

// Syntetický set musí být vždy validní (fakta obsažená v referenčním přepisu).
func TestDevSetValid(t *testing.T) {
	items, err := Load("../../../data/dev/synthetic.jsonl")
	if err != nil {
		t.Fatal(err)
	}
	if len(items) < 40 {
		t.Fatalf("čekám ≥ 40 zpráv, je %d", len(items))
	}
}
