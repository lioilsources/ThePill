EVAL_SET ?= ../data/eval/eval.jsonl

.PHONY: build test run eval vet

build:
	go build -o bin/ ./cmd/...

test:
	go test ./...

vet:
	go vet ./...

run:
	go run ./cmd/pill-core

# Proti LLM na Sparku (PILL_LLM_*). Prázdný set projde bez volání modelu.
eval:
	go run ./cmd/pill-eval -set $(EVAL_SET)
