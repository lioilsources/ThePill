// pill-core: HTTP služba /classify, /soften, /coach.
//
//	PILL_ADDR          (default :8090)
//	PILL_LLM_BASE_URL  OpenAI-kompatibilní endpoint (default http://localhost:8080/v1; adresu Sparku dej do .env)
//	PILL_LLM_API_KEY   klíč pro LiteLLM gateway
//	PILL_LLM_MODEL     LiteLLM route (default openclaw-default)
//	PILL_LLM_TIMEOUT   (default 10s)
//	PILL_TOKEN         when set, clients must send "Authorization: Bearer <token>"
package main

import (
	"log/slog"
	"net/http"
	"os"
	"strings"
	"time"

	"github.com/lioilsources/ThePill/core/internal/api"
	"github.com/lioilsources/ThePill/core/internal/config"
)

func main() {
	cfg := config.FromEnv()
	// `pill-core healthcheck`: container probe (the distroless image has no curl).
	if len(os.Args) > 1 && os.Args[1] == "healthcheck" {
		os.Exit(healthcheck(cfg.Addr))
	}
	srv := &api.Server{Model: cfg.Model(), Timeout: cfg.Timeout, Token: cfg.Token}
	hs := &http.Server{
		Addr:              cfg.Addr,
		Handler:           srv.Handler(),
		ReadHeaderTimeout: 5 * time.Second,
	}
	slog.Info("pill-core start", "addr", cfg.Addr, "model", cfg.LLMModel, "llm", cfg.LLMBaseURL, "auth", cfg.Token != "")
	if err := hs.ListenAndServe(); err != nil {
		slog.Error("pill-core", "err", err)
		os.Exit(1)
	}
}

func healthcheck(addr string) int {
	if strings.HasPrefix(addr, ":") {
		addr = "127.0.0.1" + addr
	}
	c := http.Client{Timeout: 3 * time.Second}
	res, err := c.Get("http://" + addr + "/healthz")
	if err != nil {
		return 1
	}
	res.Body.Close()
	if res.StatusCode != http.StatusOK {
		return 1
	}
	return 0
}
