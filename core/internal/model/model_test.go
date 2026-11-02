package model

import (
	"context"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"reflect"
	"testing"
	"time"
)

func TestHardFacts(t *testing.T) {
	got := HardFacts("Vyzvedni ji v 16:30, je to 2000 Kč, 3.11. a č. 12/4")
	want := []string{"16:30", "2000", "3.11", "12/4"}
	if !reflect.DeepEqual(got, want) {
		t.Fatalf("got %v want %v", got, want)
	}
}

func TestMissingFactsIgnoresCaseAndDiacritics(t *testing.T) {
	soft := "Prosí, abys vyzvedl Aničku ve školce v 16:30."
	if m := MissingFacts(soft, []string{"ANICKU", "ve skolce", "16:30"}); len(m) != 0 {
		t.Fatalf("nečekaně chybí %v", m)
	}
	if m := MissingFacts(soft, []string{"17:00"}); len(m) != 1 {
		t.Fatalf("17:00 mělo chybět, got %v", m)
	}
}

func TestExtractJSONObject(t *testing.T) {
	for in, want := range map[string]string{
		`{"a":1}`:                        `{"a":1}`,
		"```json\n{\"a\":1}\n```":        `{"a":1}`,
		`<think>{"x":0}</think> {"a":1}`: `{"a":1}`,
	} {
		got, ok := extractJSONObject(in)
		if !ok || got != want {
			t.Errorf("%q → %q,%v", in, got, ok)
		}
	}
	if _, ok := extractJSONObject("nic"); ok {
		t.Error("bez JSON nemá projít")
	}
}

func fakeLLM(t *testing.T, content string, status int) *LLM {
	t.Helper()
	srv := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path != "/v1/chat/completions" {
			t.Errorf("path %s", r.URL.Path)
		}
		var req chatReq
		_ = json.NewDecoder(r.Body).Decode(&req)
		if req.Model != "m" || req.Messages[0].Role != "system" {
			t.Errorf("špatný request: %+v", req)
		}
		w.WriteHeader(status)
		_ = json.NewEncoder(w).Encode(map[string]any{
			"choices": []any{map[string]any{"message": map[string]string{"role": "assistant", "content": content}}},
		})
	}))
	t.Cleanup(srv.Close)
	return NewLLM(srv.URL+"/v1/", "k", "m", 2*time.Second)
}

func TestLLMClassify(t *testing.T) {
	c, err := fakeLLM(t, `{"tone":"hostile","score":0.9,"reason":"křik"}`, 200).
		Classify(context.Background(), ClassifyInput{Text: "KDE JSOU KLÍČE"})
	if err != nil || c.Tone != ToneHostile {
		t.Fatalf("%+v %v", c, err)
	}
	if _, err := fakeLLM(t, `{"tone":"angry","score":0.9}`, 200).Classify(context.Background(), ClassifyInput{Text: "x"}); err != ErrBadOutput {
		t.Fatalf("neplatný tón má být ErrBadOutput, got %v", err)
	}
	if _, err := fakeLLM(t, `{}`, 500).Classify(context.Background(), ClassifyInput{Text: "x"}); err == nil {
		t.Fatal("HTTP 500 má být chyba")
	}
}

func TestLLMCoachNeedsTwoAlternatives(t *testing.T) {
	_, err := fakeLLM(t, `{"is_hostile":true,"why":"x","alternatives":["jen jedna"]}`, 200).
		Coach(context.Background(), "x", "cs")
	if err != ErrBadOutput {
		t.Fatalf("got %v", err)
	}
}
