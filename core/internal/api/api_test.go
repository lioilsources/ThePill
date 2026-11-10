package api

import (
	"bytes"
	"encoding/json"
	"errors"
	"log"
	"net/http"
	"net/http/httptest"
	"os"
	"strings"
	"testing"

	"github.com/lioilsources/ThePill/core/internal/model"
)

const secret = "TAJNÝ OBSAH ZPRÁVY"

func post(t *testing.T, m model.Model, path, body string) (*httptest.ResponseRecorder, map[string]any) {
	t.Helper()
	rec := httptest.NewRecorder()
	(&Server{Model: m}).Handler().ServeHTTP(rec, httptest.NewRequest(http.MethodPost, path, strings.NewReader(body)))
	var out map[string]any
	_ = json.Unmarshal(rec.Body.Bytes(), &out)
	return rec, out
}

var offline = model.Fake{
	ClassifyFn: func(model.ClassifyInput) (model.Classification, error) {
		return model.Classification{}, errors.New("down")
	},
	SoftenFn: func(string) (model.Softened, error) { return model.Softened{}, errors.New("down") },
	CoachFn:  func(string) (model.Coaching, error) { return model.Coaching{}, errors.New("down") },
}

func TestFailOpenWhenModelOffline(t *testing.T) {
	_, c := post(t, offline, "/classify", `{"text":"KDE JSOU KLÍČE"}`)
	if c["tone"] != "ok" || c["degraded"] != true {
		t.Errorf("classify: %v", c)
	}
	_, s := post(t, offline, "/soften", `{"text":"KDE JSOU KLÍČE"}`)
	if s["text_soft"] != "KDE JSOU KLÍČE" || s["fallback"] != true || s["degraded"] != true {
		t.Errorf("soften má vrátit originál: %v", s)
	}
	_, co := post(t, offline, "/coach", `{"text":"x"}`)
	if co["is_hostile"] != false || co["degraded"] != true {
		t.Errorf("coach: %v", co)
	}
}

func TestSoftenFactGuard(t *testing.T) {
	orig := "Ty seš k ničemu. Vyzvedni Aničku v 16:30!"
	lost := model.Fake{SoftenFn: func(string) (model.Softened, error) {
		return model.Softened{TextSoft: "Prosí, abys vyzvedl Aničku.", KeptFacts: []string{"Aničku"}}, nil
	}}
	_, s := post(t, lost, "/soften", `{"text":"`+orig+`"}`)
	if s["text_soft"] != orig || s["fallback"] != true {
		t.Errorf("ztracený čas → originál, got %v", s)
	}

	lying := model.Fake{SoftenFn: func(string) (model.Softened, error) {
		return model.Softened{TextSoft: "Prosí o vyzvednutí v 16:30.", KeptFacts: []string{"Aničku", "16:30"}}, nil
	}}
	_, s = post(t, lying, "/soften", `{"text":"`+orig+`"}`)
	if s["fallback"] != true {
		t.Errorf("deklarovaný fakt chybí v textu → originál, got %v", s)
	}

	good := model.Fake{SoftenFn: func(string) (model.Softened, error) {
		return model.Softened{TextSoft: "Prosí, abys vyzvedl Aničku v 16:30.", KeptFacts: []string{"Aničku", "16:30"}}, nil
	}}
	_, s = post(t, good, "/soften", `{"text":"`+orig+`"}`)
	if s["text_soft"] != "Prosí, abys vyzvedl Aničku v 16:30." || s["fallback"] != nil {
		t.Errorf("dobrý přepis má projít, got %v", s)
	}
}

func TestBadRequests(t *testing.T) {
	for body, code := range map[string]int{
		`nejson`:         400,
		`{"text":"   "}`: 400,
		`{"text":"` + strings.Repeat("a", maxTextRunes+1) + `"}`: 413,
	} {
		if rec, _ := post(t, model.Fake{}, "/classify", body); rec.Code != code {
			t.Errorf("%.20q → %d, chci %d", body, rec.Code, code)
		}
	}
}

func TestTextNeverLogged(t *testing.T) {
	var buf bytes.Buffer
	log.SetOutput(&buf)
	defer log.SetOutput(os.Stderr)

	for _, p := range []string{"/classify", "/soften", "/coach"} {
		post(t, model.Fake{}, p, `{"text":"`+secret+`"}`)
		post(t, offline, p, `{"text":"`+secret+`"}`)
	}
	if strings.Contains(buf.String(), secret) {
		t.Fatalf("text zprávy unikl do logu:\n%s", buf.String())
	}
}

func TestTokenRequired(t *testing.T) {
	h := (&Server{Model: offline, Token: "s3cret"}).Handler()
	do := func(path, auth string) int {
		req := httptest.NewRequest(http.MethodPost, path, strings.NewReader(`{"text":"ahoj"}`))
		if path == "/healthz" {
			req = httptest.NewRequest(http.MethodGet, path, nil)
		}
		if auth != "" {
			req.Header.Set("Authorization", auth)
		}
		rec := httptest.NewRecorder()
		h.ServeHTTP(rec, req)
		return rec.Code
	}
	if c := do("/coach", ""); c != http.StatusUnauthorized {
		t.Errorf("no token: %d", c)
	}
	if c := do("/coach", "Bearer wrong"); c != http.StatusUnauthorized {
		t.Errorf("wrong token: %d", c)
	}
	if c := do("/coach", "Bearer s3cret"); c != http.StatusOK {
		t.Errorf("good token: %d", c)
	}
	if c := do("/healthz", ""); c != http.StatusOK {
		t.Errorf("healthz must stay public: %d", c)
	}
}
