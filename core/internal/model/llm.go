package model

import (
	"bytes"
	"context"
	"encoding/json"
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
	Model          string            `json:"model"`
	Messages       []chatMsg         `json:"messages"`
	Temperature    float64           `json:"temperature"`
	MaxTokens      int               `json:"max_tokens"`
	ResponseFormat map[string]string `json:"response_format,omitempty"`
}

type chatResp struct {
	Choices []struct {
		Message chatMsg `json:"message"`
	} `json:"choices"`
}

func (l *LLM) chatJSON(ctx context.Context, system string, shots []shot, user string, out any) error {
	msgs := []chatMsg{{Role: "system", Content: system}}
	for _, s := range shots {
		msgs = append(msgs, chatMsg{"user", s.user}, chatMsg{"assistant", s.assistant})
	}
	msgs = append(msgs, chatMsg{"user", user})

	body, _ := json.Marshal(chatReq{
		Model:          l.Model,
		Messages:       msgs,
		Temperature:    0,
		MaxTokens:      600,
		ResponseFormat: map[string]string{"type": "json_object"},
	})
	req, err := http.NewRequestWithContext(ctx, http.MethodPost, l.BaseURL+"/chat/completions", bytes.NewReader(body))
	if err != nil {
		return err
	}
	req.Header.Set("Content-Type", "application/json")
	if l.APIKey != "" {
		req.Header.Set("Authorization", "Bearer "+l.APIKey)
	}
	resp, err := l.HTTP.Do(req)
	if err != nil {
		return fmt.Errorf("llm: %w", err)
	}
	defer resp.Body.Close()
	raw, err := io.ReadAll(io.LimitReader(resp.Body, 1<<20))
	if err != nil {
		return fmt.Errorf("llm: %w", err)
	}
	if resp.StatusCode != http.StatusOK {
		// Tělo chyby neobsahuje text zprávy jen u některých gatewayí — radši ho nevracíme.
		return fmt.Errorf("llm: HTTP %d", resp.StatusCode)
	}
	var cr chatResp
	if err := json.Unmarshal(raw, &cr); err != nil || len(cr.Choices) == 0 {
		return ErrBadOutput
	}
	obj, ok := extractJSONObject(cr.Choices[0].Message.Content)
	if !ok {
		return ErrBadOutput
	}
	if err := json.Unmarshal([]byte(obj), out); err != nil {
		return ErrBadOutput
	}
	return nil
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

func userMsg(text, lang string) string {
	if lang == "" || lang == "cs" {
		return text
	}
	return fmt.Sprintf("[jazyk zprávy: %s — odpověz ve stejném jazyce]\n%s", lang, text)
}

func (l *LLM) Classify(ctx context.Context, in ClassifyInput) (Classification, error) {
	var c Classification
	if err := l.chatJSON(ctx, classifySystem, classifyShots, userMsg(in.Text, in.Lang), &c); err != nil {
		return Classification{}, err
	}
	if !c.Tone.Valid() || c.Score < 0 || c.Score > 1 {
		return Classification{}, ErrBadOutput
	}
	return c, nil
}

func (l *LLM) Soften(ctx context.Context, text, lang string) (Softened, error) {
	var s Softened
	if err := l.chatJSON(ctx, softenSystem, softenShots, userMsg(text, lang), &s); err != nil {
		return Softened{}, err
	}
	if strings.TrimSpace(s.TextSoft) == "" {
		return Softened{}, ErrBadOutput
	}
	if s.KeptFacts == nil {
		s.KeptFacts = []string{}
	}
	return s, nil
}

func (l *LLM) Coach(ctx context.Context, text, lang string) (Coaching, error) {
	var c Coaching
	if err := l.chatJSON(ctx, coachSystem, coachShots, userMsg(text, lang), &c); err != nil {
		return Coaching{}, err
	}
	if c.IsHostile && len(c.Alternatives) < 2 {
		return Coaching{}, ErrBadOutput
	}
	if !c.IsHostile {
		c.Why, c.Alternatives = "", []string{}
	}
	if len(c.Alternatives) > 2 {
		c.Alternatives = c.Alternatives[:2]
	}
	return c, nil
}
