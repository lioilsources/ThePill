// pill-core: HTTP služba /classify, /soften, /coach.
//
//	PILL_ADDR          (default :8090)
//	PILL_LLM_BASE_URL  OpenAI-kompatibilní endpoint (default https://llm.ol1n.com/v1)
//	PILL_LLM_API_KEY   klíč pro LiteLLM gateway
//	PILL_LLM_MODEL     LiteLLM route (default openclaw-default)
//	PILL_LLM_TIMEOUT   (default 20s)
package main

import (
	"log"
	"net/http"
	"time"

	"github.com/lioilsources/ThePill/core/internal/api"
	"github.com/lioilsources/ThePill/core/internal/config"
)

func main() {
	cfg := config.FromEnv()
	srv := &api.Server{Model: cfg.Model(), Timeout: cfg.Timeout}
	hs := &http.Server{
		Addr:              cfg.Addr,
		Handler:           srv.Handler(),
		ReadHeaderTimeout: 5 * time.Second,
	}
	log.Printf("pill-core na %s, model %s @ %s", cfg.Addr, cfg.LLMModel, cfg.LLMBaseURL)
	log.Fatal(hs.ListenAndServe())
}
