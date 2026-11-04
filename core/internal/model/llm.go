package model

import (
	"bytes"
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"net/http"
	"strings"
	"time"
)

// LLM volá OpenAI-kompatibilní endpoint (LiteLLM gateway na Sparku → vLLM).
type LLM struct {
	BaseURL string // např. https://llm.ol1n.com/v1
	APIKey  string
	Model   string // LiteLLM route, např. openclaw-default
	HTTP    *http.Client

	// Debug dostane surovou odpověď modelu, když je neplatná. Jen pro pill-eval
	// nad syntetickými daty — server ho nikdy nenastavuje (text zpráv se neloguje).
	Debug func(op, raw string)
}

func NewLLM(baseURL, apiKey, model string, timeout time.Duration) *LLM {
	return &LLM{
		BaseURL: strings.TrimRight(baseURL, "/"),
		APIKey:  apiKey,
		Model:   model,
		HTTP:    &http.Client{Timeout: timeout},
	}
}

type chatMsg struct {
	Role    string `json:"role"`
	Content string `json:"content"`
}

type chatReq struct {
	Model          string    `json:"model"`
	Messages       []chatMsg `json:"messages"`
	Temperature    float64   `json:"temperature"`
	MaxTokens      int       `json:"max_tokens"`
	ResponseFormat any       `json:"response_format,omitempty"`
}

type chatResp struct {
	Choices []struct {
		Message chatMsg `json:"message"`
	} `json:"choices"`
}

// chatJSON zavolá model a jednou zopakuje, když výstup neprojde parserem nebo validací.
func (l *LLM) chatJSON(ctx context.Context, op, system string, shots []shot, user string, out any, valid func() bool) error {
	var err error
	for attempt := 0; attempt < 2; attempt++ {
		var raw string
		raw, err = l.chatOnce(ctx, op, system, shots, user, out)
		if err == nil && !valid() {
			err = ErrBadOutput
		}
		if err == nil {
			return nil
		}
		if l.Debug != nil && errors.Is(err, ErrBadOutput) {
			l.Debug(op, raw)
		}
		if !errors.Is(err, ErrBadOutput) {
			return err
		}
	}
	return err
}

func (l *LLM) chatOnce(ctx context.Context, op, system string, shots []shot, user string, out any) (string, error) {
	msgs := []chatMsg{{Role: "system", Content: system}}
	for _, s := range shots {
		msgs = append(msgs, chatMsg{"user", s.user}, chatMsg{"assistant", s.assistant})
	}
	msgs = append(msgs, chatMsg{"user", user})

	body, _ := json.Marshal(chatReq{
		Model:          l.Model,
		Messages:       msgs,
		Temperature:    temperature(op),
		MaxTokens:      1000,
		ResponseFormat: responseFormat(op),
	})
	req, err := http.NewRequestWithContext(ctx, http.MethodPost, l.BaseURL+"/chat/completions", bytes.NewReader(body))
	if err != nil {
		return "", err
	}
	req.Header.Set("Content-Type", "application/json")
	if l.APIKey != "" {
		req.Header.Set("Authorization", "Bearer "+l.APIKey)
	}
	resp, err := l.HTTP.Do(req)
	if err != nil {
		return "", fmt.Errorf("llm: %w", err)
	}
	defer resp.Body.Close()
	raw, err := io.ReadAll(io.LimitReader(resp.Body, 1<<20))
	if err != nil {
		return "", fmt.Errorf("llm: %w", err)
	}
	if resp.StatusCode != http.StatusOK {
		// Tělo chyby neobsahuje text zprávy jen u některých gatewayí — radši ho nevracíme.
		return "", fmt.Errorf("llm: HTTP %d", resp.StatusCode)
	}
	var cr chatResp
	if err := json.Unmarshal(raw, &cr); err != nil || len(cr.Choices) == 0 {
		return string(raw), ErrBadOutput
	}
	content := cr.Choices[0].Message.Content
	obj, ok := extractJSONObject(content)
	if !ok {
		return content, ErrBadOutput
	}
	if err := json.Unmarshal([]byte(obj), out); err != nil {
		return content, ErrBadOutput
	}
	return content, nil
}

// extractJSONObject vytáhne první {...} z odpovědi (model občas přidá ```json nebo <think>).
func extractJSONObject(s string) (string, bool) {
	if i := strings.LastIndex(s, "</think>"); i >= 0 {
		s = s[i+len("</think>"):]
	}
	start := strings.Index(s, "{")
	end := strings.LastIndex(s, "}")
	if start < 0 || end <= start {
		return "", false
	}
	return s[start : end+1], true
}

// Klasifikace a přepis deterministicky (srovnatelné běhy evalu); kouč smí být pestřejší.
func temperature(op string) float64 {
	if op == "coach" {
		return 0.3
	}
	return 0
}

func userMsg(text, lang string) string {
	if lang == "" || lang == "cs" {
		return text
	}
	return fmt.Sprintf("[jazyk zprávy: %s — odpověz ve stejném jazyce]\n%s", lang, text)
}

func (l *LLM) Classify(ctx context.Context, in ClassifyInput) (Classification, error) {
	var c Classification
	err := l.chatJSON(ctx, "classify", classifySystem, classifyShots, userMsg(in.Text, in.Lang), &c, func() bool {
		return c.Tone.Valid() && c.Score >= 0 && c.Score <= 1
	})
	if err != nil {
		return Classification{}, err
	}
	return c, nil
}

func (l *LLM) Soften(ctx context.Context, text, lang string) (Softened, error) {
	var s Softened
	err := l.chatJSON(ctx, "soften", softenSystem, softenShots, userMsg(text, lang), &s, func() bool {
		return strings.TrimSpace(s.TextSoft) != ""
	})
	if err != nil {
		return Softened{}, err
	}
	if s.KeptFacts == nil {
		s.KeptFacts = []string{}
	}
	return s, nil
}

func (l *LLM) Coach(ctx context.Context, text, lang string) (Coaching, error) {
	var c Coaching
	err := l.chatJSON(ctx, "coach", coachSystem, coachShots, userMsg(text, lang), &c, func() bool {
		return !c.IsHostile || len(nonEmpty(c.Alternatives)) >= 2
	})
	if err != nil {
		return Coaching{}, err
	}
	if !c.IsHostile {
		c.Why, c.Alternatives = "", []string{}
	}
	c.Alternatives = nonEmpty(c.Alternatives)
	if len(c.Alternatives) > 2 {
		c.Alternatives = c.Alternatives[:2]
	}
	return c, nil
}

func nonEmpty(xs []string) []string {
	out := []string{}
	for _, x := range xs {
		if strings.TrimSpace(x) != "" {
			out = append(out, x)
		}
	}
	return out
}
