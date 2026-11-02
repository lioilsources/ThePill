// Package config čte nastavení z prostředí; sdílí ho pill-core i pill-eval.
package config

import (
	"os"
	"time"

	"github.com/lioilsources/ThePill/core/internal/model"
)

type Config struct {
	Addr       string
	LLMBaseURL string
	LLMAPIKey  string
	LLMModel   string
	Timeout    time.Duration
}

func FromEnv() Config {
	c := Config{
		Addr:       env("PILL_ADDR", ":8090"),
		LLMBaseURL: env("PILL_LLM_BASE_URL", "https://llm.ol1n.com/v1"),
		LLMAPIKey:  os.Getenv("PILL_LLM_API_KEY"),
		LLMModel:   env("PILL_LLM_MODEL", "openclaw-default"),
		Timeout:    20 * time.Second,
	}
	if d, err := time.ParseDuration(os.Getenv("PILL_LLM_TIMEOUT")); err == nil && d > 0 {
		c.Timeout = d
	}
	return c
}

func (c Config) Model() model.Model {
	return model.NewLLM(c.LLMBaseURL, c.LLMAPIKey, c.LLMModel, c.Timeout)
}

func env(k, def string) string {
	if v := os.Getenv(k); v != "" {
		return v
	}
	return def
}
