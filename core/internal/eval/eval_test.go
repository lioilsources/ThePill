package eval

import (
	"context"
	"strings"
	"testing"

	"github.com/lioilsources/ThePill/core/internal/model"
)

const set = `
// komentář se ignoruje
{"id":"k1","text":"KDE SAKRA JSOU KLÍČE","tone":"hostile","text_soft":"Ptá se, kde jsou klíče.","facts":["klíče"]}
{"id":"k2","text":"Vyzvedni ji v 16:30, ty nemehlo","tone":"hostile","text_soft":"Prosí o vyzvednutí v 16:30.","facts":[]}
{"id":"n1","text":"Koupíš mlíko?","tone":"ok"}
`

func TestParse(t *testing.T) {
	items, err := Parse(strings.NewReader(set))
	if err != nil || len(items) != 3 {
		t.Fatalf("%v %d", err, len(items))
	}
	if _, err := Parse(strings.NewReader(`{"text":"x","tone":"hostile"}`)); err == nil {
		t.Error("ostrá bez text_soft má selhat")
	}
	if _, err := Parse(strings.NewReader(`{"text":"x","tone":"vztek"}`)); err == nil {
		t.Error("neznámý tón má selhat")
	}
}

func TestEmptySetPasses(t *testing.T) {
	if f := Run(context.Background(), model.Fake{}, nil).Failures(); len(f) != 0 {
		t.Fatal(f)
	}
}

func TestRun(t *testing.T) {
	items, _ := Parse(strings.NewReader(set))
	m := model.Fake{
		ClassifyFn: func(in model.ClassifyInput) (model.Classification, error) {
			if strings.Contains(in.Text, "KLÍČE") {
				return model.Classification{Tone: model.ToneHostile}, nil
			}
			return model.Classification{Tone: model.ToneOK}, nil // k2 netrefí
		},
		SoftenFn: func(text string) (model.Softened, error) {
			// ztratí čas → pojistka vrátí originál, uživatel fakt neztratí
			return model.Softened{TextSoft: "Prosí o vyzvednutí, ptá se na klíče."}, nil
		},
	}
	r := Run(context.Background(), m, items)
	if r.Sharp != 2 || r.Neutral != 1 || r.SharpCaught != 1 {
		t.Fatalf("%+v", r)
	}
	if r.RawLostFacts != 1 || r.Fallbacks != 1 || r.FinalLostFacts != 0 {
		t.Fatalf("soften: raw=%d fb=%d final=%d", r.RawLostFacts, r.Fallbacks, r.FinalLostFacts)
	}
	f := r.Failures()
	if len(f) != 1 || !strings.Contains(f[0], "recall") {
		t.Fatalf("čekám jen fail na recall (50 %%), got %v", f)
	}
}

func TestReadmeExampleIsValid(t *testing.T) {
	ex := `{"id":"p01-001","text":"KDE SAKRA JSOU KLÍČE","tone":"hostile","text_soft":"Ptá se, kde jsou klíče.","facts":["klíč"]}
{"id":"p01-002","text":"Vyzvedni Aničku ve školce v 16:30, nebo si mě nepřej","tone":"manipulative","text_soft":"Prosí, abys vyzvedl Aničku ve školce v 16:30.","facts":["Anič","škol","16:30"]}
{"id":"p01-003","text":"Koupíš cestou mlíko? Díky","tone":"ok"}`
	if _, err := Parse(strings.NewReader(ex)); err != nil {
		t.Fatal(err)
	}
	bad := `{"text":"Vyzvedni ji ve školce","tone":"hostile","text_soft":"Prosí o vyzvednutí ve školce.","facts":["školk"]}`
	if _, err := Parse(strings.NewReader(bad)); err == nil {
		t.Fatal("fakt, který není ani v referenci, má selhat")
	}
}
