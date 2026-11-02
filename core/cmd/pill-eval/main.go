// pill-eval: změří model na eval setu a skončí s chybou, když nesplní cíle.
//
//	go run ./cmd/pill-eval -set ../data/eval/eval.jsonl
//
// Model se konfiguruje stejnými PILL_LLM_* proměnnými jako pill-core.
package main

import (
	"context"
	"errors"
	"flag"
	"fmt"
	"io/fs"
	"os"

	"github.com/lioilsources/ThePill/core/internal/config"
	"github.com/lioilsources/ThePill/core/internal/eval"
)

func main() {
	set := flag.String("set", "../data/eval/eval.jsonl", "eval set (JSONL)")
	flag.Parse()

	items, err := eval.Load(*set)
	if errors.Is(err, fs.ErrNotExist) {
		// Reálný set je v .gitignore (soukromé zprávy) — v čistém klonu chybí.
		fmt.Fprintf(os.Stderr, "pill-eval: %s neexistuje, beru jako prázdný set\n", *set)
		err = nil
	}
	if err != nil {
		fmt.Fprintln(os.Stderr, "pill-eval:", err)
		os.Exit(2)
	}
	var rep eval.Report
	if len(items) > 0 {
		rep = eval.Run(context.Background(), config.FromEnv().Model(), items)
	}
	rep.Print(os.Stdout)
	if f := rep.Failures(); len(f) > 0 {
		for _, x := range f {
			fmt.Println("FAIL:", x)
		}
		os.Exit(1)
	}
}
