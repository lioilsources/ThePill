package model

import "context"

// Fake je pevně naprogramovaný model pro testy a lokální vývoj bez Sparku.
type Fake struct {
	ClassifyFn func(ClassifyInput) (Classification, error)
	SoftenFn   func(text string) (Softened, error)
	CoachFn    func(text string) (Coaching, error)
}

func (f Fake) Classify(_ context.Context, in ClassifyInput) (Classification, error) {
	if f.ClassifyFn == nil {
		return Classification{Tone: ToneOK}, nil
	}
	return f.ClassifyFn(in)
}

func (f Fake) Soften(_ context.Context, text, _ string) (Softened, error) {
	if f.SoftenFn == nil {
		return Softened{TextSoft: text, KeptFacts: []string{}}, nil
	}
	return f.SoftenFn(text)
}

func (f Fake) Coach(_ context.Context, text, _ string) (Coaching, error) {
	if f.CoachFn == nil {
		return Coaching{Alternatives: []string{}}, nil
	}
	return f.CoachFn(text)
}
