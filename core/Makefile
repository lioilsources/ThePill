EVAL_SET ?= ../data/eval/eval.jsonl
DEV_SET  ?= ../data/dev/synthetic.jsonl

# Lokální klíče (PILL_LLM_API_KEY …) — soubor je v .gitignore.
-include ../.env
export

.PHONY: build test run eval eval-dev vet

build:
	go build -o bin/ ./cmd/...

test:
	go test ./...

vet:
	go vet ./...

run:
	go run ./cmd/pill-core

# Proti LLM na Sparku (PILL_LLM_*). Prázdný / chybějící set projde bez volání modelu.
eval: test
	go run ./cmd/pill-eval -set $(EVAL_SET)

# Syntetický set pro ladění promptů — cíle jen informativní.
eval-dev: test
	go run ./cmd/pill-eval -v -set $(DEV_SET)
