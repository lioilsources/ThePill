// Package model definuje rozhraní mozku pill-core. Stejnou signaturu bude mít
// později on-device model (LiteRT / Core AI), takže HTTP vrstva ani eval se
// při přechodu nemění.
package model

import (
	"context"
	"errors"
)

// Tone je výsledek klasifikace tónu zprávy.
type Tone string

const (
	ToneOK           Tone = "ok"
	ToneTense        Tone = "tense"
	ToneHostile      Tone = "hostile"
	ToneManipulative Tone = "manipulative"
)

// Valid hlásí, zda jde o jednu ze čtyř povolených hodnot.
func (t Tone) Valid() bool {
	switch t {
	case ToneOK, ToneTense, ToneHostile, ToneManipulative:
		return true
	}
	return false
}

// Sharp = zpráva, kterou má Pilulka změkčit / kouč zachytit.
func (t Tone) Sharp() bool { return t == ToneHostile || t == ToneManipulative }

type ClassifyInput struct {
	Text    string `json:"text"`
	Sender  string `json:"sender,omitempty"`
	Channel string `json:"channel,omitempty"`
	Lang    string `json:"lang,omitempty"`
}

type Classification struct {
	Tone   Tone    `json:"tone"`
	Score  float64 `json:"score"`
	Reason string  `json:"reason"`
}

type Softened struct {
	TextSoft  string   `json:"text_soft"`
	KeptFacts []string `json:"kept_facts"`
}

type Coaching struct {
	IsHostile    bool     `json:"is_hostile"`
	Why          string   `json:"why"`
	Alternatives []string `json:"alternatives"`
}

// Model je společné rozhraní pro serverový LLM i budoucí on-device model.
type Model interface {
	Classify(ctx context.Context, in ClassifyInput) (Classification, error)
	Soften(ctx context.Context, text, lang string) (Softened, error)
	Coach(ctx context.Context, text, lang string) (Coaching, error)
}

// ErrBadOutput = model odpověděl, ale ne ve tvaru, který umíme použít.
var ErrBadOutput = errors.New("model: neplatný výstup")
