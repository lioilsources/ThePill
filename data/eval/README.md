# Eval set — `/classify`, `/soften`, `/coach`

Soubor `eval.jsonl`: jeden JSON objekt na řádek. Prázdné řádky a řádky začínající `//` se přeskočí.

| pole | povinné | význam |
|---|---|---|
| `id` | ne | stabilní identifikátor (např. `p03-017` = pár 3, zpráva 17); jinak číslo řádku |
| `text` | ano | původní zpráva, anonymizovaná |
| `tone` | ano | `ok` · `tense` · `hostile` · `manipulative` |
| `text_soft` | u `hostile`/`manipulative` | jak by zpráva *měla* znít — ručně napsaná referenční verze |
| `facts` | ne (u ostrých skoro vždy) | fakta, která přepis **musí** obsahovat |

```jsonl
{"id":"p01-001","text":"KDE SAKRA JSOU KLÍČE","tone":"hostile","text_soft":"Ptá se, kde jsou klíče.","facts":["klíč"]}
{"id":"p01-002","text":"Vyzvedni Aničku ve školce v 16:30, nebo si mě nepřej","tone":"manipulative","text_soft":"Prosí, abys vyzvedl Aničku ve školce v 16:30.","facts":["Anič","škol","16:30"]}
{"id":"p01-003","text":"Koupíš cestou mlíko? Díky","tone":"ok"}
```

## Jak psát `facts`
- Kontrola je **podřetězec po normalizaci** (malá písmena, bez diakritiky). Proto piš krátké kmeny, které přežijí skloňování: `škol`, ne `ve školce` (pozor na k→c: „školka" × „školce"); `Anič`, ne `Aničku`.
- Čísla, časy, data a částky (`16:30`, `2000`, `3.11`) se kontrolují **automaticky** — psát je sem nemusíš.
- Fakt = cokoli, podle čeho příjemce jedná: čas, místo, osoba, věc, žádost, termín, částka. Nadávka ani výčitka fakt není.

## Co set měří (`make eval`)
| metrika | cíl | |
|---|---|---|
| ztracené fakty v `/soften` (po pojistce) | **0** | tvrdá — build neprojde |
| hostile recall (`hostile`+`manipulative` poznané jako ostré) | ≥ 85 % | |
| FP na neutrálních (`ok` označené jako ostré) | ≤ 5 % | |
| coach recall / FP, míra fallbacku `/soften` | report | fallback = pojistka vrátila originál; vysoká míra = model ztrácí fakta |

## Sběr (fáze 0)
- ≥ 150 ostrých + ≥ 150 neutrálních zpráv mezi partnery, **se souhlasem obou**.
- Anonymizovat před uložením: jména dětí → jiná česká jména, místa → obecná (`školka`, `Lidl`), telefony a adresy pryč. Časy a částky ponechat — na nich se měří.
- `tense` se do recall ani FP nepočítá; přesto ho sbírat, ukáže, kam model padá v confusion matici.
- Few-shot příklady v `core/internal/model/prompts.go` **neberte ze setu** — jinak se měří na tom, co model viděl.
- `data/eval/*.jsonl` je v `.gitignore`: obsahuje zprávy reálných lidí a repo je veřejné. Set drž lokálně (nebo v privátním repu / zašifrovaný); bez něj `make eval` projde jako prázdný.
