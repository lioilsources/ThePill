# ThePill

## Účel
Antistresová apka: změkčuje ostré příchozí zprávy a koučuje před odesláním vlastních. Backend `pill-core` (Go) + Flutter apka s nativní klávesnicí-koučem. Plán: `PILL_PLAN.md`.

## Build a test
```
cd app && flutter analyze --no-fatal-infos && flutter test   # gate apky (jako ci.yml)
cd core && go vet ./... && go test ./...                     # gate pill-core (jako ci.yml)
make test | make run | make eval                             # root Makefile deleguje do core/
```
Eval proti modelu na SPARKu jen přes broker: `sparkctl exec thepill qwen36 30 10 "pill eval" -- make eval`.

## Mapa
- `core/` pill-core (Go): `cmd/pill-core` (HTTP /classify /soften /coach), `cmd/pill-eval`, `internal/`
- `app/` Flutter apka; klávesnice nativně v `app/android/…/PillKeyboardService.kt` a `app/ios/PillKeyboard/`
- `data/eval/` eval set (JSONL), `data/dev/` syntetický set na ladění promptů
- `deploy/joda/` nasazení pill-core na JODU (`deploy.sh`, compose, Caddy, cloudflared)
- `docs/` release, ruční test klávesnice, rozhovor s páry, privacy/support stránky
- `.github/workflows/` `ci.yml`, `release-ios.yml`, `release-android.yml` (tag `v*`)

## Invarianty
- Nikdy neblokovat zprávu: model nedostupný → `degraded: true`, zpráva projde.
- `/soften` musí zachovat čísla, časy a `kept_facts`, jinak vrátí originál (`fallback: true`).
- Text zpráv se neloguje (`TestTextNeverLogged`). Klávesnice nic neodesílá, text nahradí jen po tapnutí; citlivá pole se neposílají.
- Adresa LLM gateway jen v `.env` (`PILL_LLM_BASE_URL`), viz `.env.example`.
- `deploy/joda/deploy.sh` jen na výslovné „nasaď“.

## Odchylky
`release-ios.yml` se liší od golden šablony Distribution (druhý profil pro klávesnici), viz `docs/release.md`.

## Kam dál
`README.md`, `PILL_PLAN.md`, `docs/release.md`, `docs/macbook-1b-klavesnice.md`, `Prompts/`
