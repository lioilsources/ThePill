# The Pill

Antistresová apka: změkčuje ostré příchozí zprávy a koučuje před odesláním vlastních. Plán: [`PILL_PLAN.md`](PILL_PLAN.md) (nahrazuje `Prompts/00-EMOTIONS_PLAN.md`, ten zůstává jako rešerše platforem).

```
core/            pill-core (Go) — /classify /soften /coach, pill-eval
app/             Flutter apka + klávesnice-kouč (Android IME, iOS Keyboard Extension)
data/eval/       eval set (JSONL) + formát; data/dev/ syntetický set na ladění
docs/            scénář rozhovoru s páry (fáze 0), zadání pro MacBook (fáze 1b)
```

## app — klávesnice-kouč (fáze 1b)

Flutter = onboarding, nastavení serveru, „Vyzkoušej kouče“. Klávesnice jsou nativní:
`app/android/.../PillKeyboardService.kt` a `app/ios/PillKeyboard/`. Po pauze v psaní pošlou
rozepsanou zprávu na `/coach` a při útoku ukážou lištu se dvěma alternativami; text nahradí
jen po tapnutí, nikdy nic neodešlou. Citlivá pole (heslo, čísla, e-mail) se neposílají.

```sh
cd app && flutter analyze && flutter test
```
Buildy a ruční test: [`docs/macbook-1b-klavesnice.md`](docs/macbook-1b-klavesnice.md).

## pill-core

```sh
make test     # unit testy, bez modelu
make eval     # změří model na data/eval/eval.jsonl; prázdný set projde
make run      # :8090
```

| proměnná | default |
|---|---|
| `PILL_ADDR` | `:8090` |
| `PILL_LLM_BASE_URL` | `http://localhost:8080/v1` — adresu Sparku dej do `.env` (viz `.env.example`) |
| `PILL_LLM_API_KEY` | — |
| `PILL_LLM_MODEL` | `openclaw-default` (Qwen3.6-35B-A3B) |
| `PILL_LLM_TIMEOUT` | `20s` |

```sh
curl -XPOST :8090/classify -d '{"text":"KDE SAKRA JSOU KLÍČE","sender":"partner","channel":"whatsapp"}'
# {"tone":"hostile","score":0.93,"reason":"křik a osobní útok"}
curl -XPOST :8090/soften   -d '{"text":"KDE SAKRA JSOU KLÍČE"}'
# {"text_soft":"Ptá se, kde jsou klíče.","kept_facts":["klíče"]}
curl -XPOST :8090/coach    -d '{"text":"Na tebe se nedá spolehnout"}'
# {"is_hostile":true,"why":"…","alternatives":["…","…"]}
```

**Pojistky (fáze 3) jsou už v kostře:**
- Model nedostupný nebo nesmyslná odpověď → `degraded: true`, zpráva projde (classify `ok`, soften vrátí originál, coach mlčí). Nikdy neblokuje.
- `/soften`: všechna čísla/časy originálu a všechna fakta, která model deklaroval v `kept_facts`, musí být v přepisu — jinak vrátí originál s `fallback: true`.
- Text zpráv se neloguje (test `TestTextNeverLogged`); metriky na `GET /debug/vars`.
- `model.Model` je rozhraní — on-device model dostane stejnou signaturu.

### Eval proti Sparku
GPU jen přes broker, ne přímo:
```sh
sparkctl exec thepill qwen36 30 10 "pill eval" -- make eval
```
