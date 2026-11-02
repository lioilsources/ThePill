# THE PILL — plán (handoff pro Claude Code)

Nahrazuje STRAZCE_PLAN.md (2026-11-02). Stack: Flutter (klient, Android + iOS), Go (`pill-core`), model na Sparku / později on-device.

## 0. Co to je

**The Pill** — antistresová apka pro telefon. Dvě síly jedné pilulky:

| tier | co dělá | pro koho | plátce |
|---|---|---|---|
| **The Pill** | příchozí zprávy od toxických lidí přepíše na stressless verzi; když sám píšeš hejt, před odesláním vysvětlí, jak to říct jinak | maminky s dětmi < 5 a jejich partneři | pár (oba) |
| **Zombie Pill** (interní název; v listingu „Ochrana rodičů") | kompletně odstíní hoaxy, deepfaky, podvody a hejty z mailu a messengerů; dítě spravuje rodičův telefon | senioři | dospělé dítě |

Obě stojí na stejném `pill-core`. Nic se nikdy nemaže — jen přepisuje, odkládá, schovává.

## 1. Pořadí

**Fáze 1 = párová Pilulka.** Technicky nejjednodušší (text dovnitř, text ven), žádná SMS oprávnění od Googlu, jde na obě platformy, sedí k značce.
**Fáze 2 = Zombie Pill.** Jasný plátce, ale hoax detekce je jiný klasifikátor + Play review na SMS/notifikace. Začít až na ověřeném jádru.

### Fáze 0 — Ověření (2 týdny)
- 5 párů s dětmi < 5 (ideálně známí): kde se hádají (WhatsApp / iMessage / Messenger), jak vypadá typická „špatná" zpráva, jestli by si **oba** nainstalovali apku, která jim přepisuje, co si píšou. Pokud ne oba → párový model nefunguje, zůstává jen jednostranný příchozí filtr na Androidu.
- Sesbírat ≥150 reálných „ostrých" zpráv mezi partnery + ≥150 neutrálních (se souhlasem, anonymizovat). Ručně napsat ke každé ostré „jak by měla znít". To je eval set pro `/soften` i `/coach`.
- Stop kritérium: když tři z pěti párů řeknou „tajně bych to partnerovi nedal a otevřeně taky ne", zaparkovat.

### Fáze 1a — `pill-core` (Go, 2 týdny)
- `POST /classify` `{text, sender, channel, lang}` → `{tone: ok|tense|hostile|manipulative, score, reason}`
- `POST /soften` `{text, lang}` → `{text_soft, kept_facts[]}` — **zachovat každou faktickou informaci** (čas, místo, žádost), odstranit tón. „KDE SAKRA JSOU KLÍČE" → „Ptá se, kde jsou klíče."
- `POST /coach` `{text, lang}` → `{is_hostile, why, alternatives[2]}` — vysvětlení + dvě přeformulace, nikdy automatický přepis bez souhlasu pisatele.
- Model: malý LLM na Sparku (4–8B, few-shot, JSON), čeština první. Měřit na eval setu: **žádný ztracený fakt v `/soften`** (tvrdá metrika), hostile recall ≥ 85 %, FP na neutrálních ≤ 5 %.
- Soukromí: text se neloguje, jen metriky. Připravit rozhraní pro on-device model (stejná signatura).
- Repo `lioilsources/ThePill`, `core/`, `make eval`.

### Fáze 1b — Odchozí kouč (Flutter, 2–3 týdny) — funguje všude
- **iOS:** vlastní klávesnice (Keyboard Extension) + share-sheet. Klávesnice vidí, co píšeš; při `hostile` zobrazí lištu „Tohle zní jako útok — zobrazit jinak?". Nikdy neodesílá nic sama.
- **Android:** stejná klávesnice (IME) + Accessibility volitelně později.
- Bez párování funguje jako osobní kouč = první verze, kterou lze pustit do storu.

### Fáze 1c — Příchozí změkčení (Flutter, 2–3 týdny) — jen Android
- `NotificationListenerService`: zachytí notifikaci z WhatsApp/Messenger/Viber/SMS, zruší ji, zobrazí vlastní s přepsaným textem. Originál dostupný na klik („zobrazit původní").
- Na iOS nejde → v apce to říct otevřeně, nenabízet.
- Jen pro kontakty označené jako „pilulka" (partner, toxický příbuzný), ne globálně.

### Fáze 1d — Párování
- QR / kód: oba potvrdí „máme Pilulku". Od té chvíle má každý kouč zapnutý pro zprávy tomu druhému a příjemce vidí změkčené verze. Oboustranný souhlas je podmínka, ne feature.
- Týdenní „teploměr" pro pár: kolik zpráv bylo ostrých, kolik kouč změkčil. Žádné citace, jen čísla.
- Vypnout kdykoliv, jednostranně.

### Fáze 2 — Zombie Pill / Ochrana rodičů (po launchi fáze 1)
- Hoax vrstva do `pill-core`: pravidla (URL zkracovače, „přepošli", výhra, banka + odkaz) → DB známých řetězáků (seed z Demagog, Manipulátoři.cz, vlastní rostoucí z karantény) → LLM jen pro zbytek. Cíl: scam recall ≥ 90 %, FP na rodinných zprávách ≤ 3 %.
- Android: `NotificationListener` + **výchozí SMS apka** (jediná cesta ke čtení/schovávání SMS; vlastní minimální SMS UI pro seniora). Gmail/IMAP.
- Karanténa + denní souhrn, bílý seznam rodiny projde vždy, klíčová slova (nemocnice, lékař, policie, soud, exekuce) projdou vždy, úřady projdou vždy.
- Role **Opatrovník**: dítě spáruje přes QR, vidí týdenní report, vrací zprávy z karantény, spravuje bílý seznam. Push při scam > 0.9.
- Play: deklarace pro NotificationListener a default-SMS podat hned na začátku fáze 2 (týdny).

### Fáze 3 — Pojistky (průběžně, blokují launch)
- Model offline → propustit vše + varování; nikdy tiše blokovat.
- `/soften` nikdy nemění fakta; při nejistotě ukázat originál.
- Kouč nikdy neodesílá a nepřepisuje bez tapnutí.
- GDPR: zprávy třetích osob → on-device preferované; server transientně bez logů. Jednoduché zásady, které pochopí oba partneři i syn seniora.

### Fáze 4 — Pilot (4 týdny)
- 5 párů z fáze 0. Metriky: kolikrát kouč zasáhl, kolikrát pisatel přijal alternativu (cíl > 30 %), retence po 4 týdnech, odpověď „bylo doma klidněji?".

### Fáze 5 — Launch
- App Store + Play, CZ první. Osobní kouč zdarma (akvizice), párový režim **149 Kč/měs. za pár** nebo 990 Kč/rok. Zombie Pill později 99 Kč/měs., platí dítě. Zvážit v Ol1n Pass.
- Listing: „Pilulka na klid v rodině" — žádná smrt, žádní zombie navenek. Apple review: název The Pill zdůvodnit jako metaforu, mít připravené.
- Kanály: skupiny rodičů, pediatři, poradny pro páry; pro Zombie Pill: skupiny pečujících, Elpida, banky (prevence podvodů, olin.now/business).

## 2. Architektura

```
[Flutter klient — Android + iOS]
   ├─ Keyboard Extension / IME  → /coach
   ├─ NotificationListener (Android) → /soften, /classify
   ├─ default SMS + IMAP (Android, fáze 2) → /classify (hoax)
   ├─ lokální DB (kontakty „pilulka", karanténa, bílý seznam, párování)
   └─ HTTPS → pill-core
[pill-core (Go)]
   ├─ /classify  /soften  /coach  (/hoax ve fázi 2)
   ├─ rules → hoaxdb → llm (Spark, vLLM); rozhraní pro on-device
   └─ žádné ukládání textu, jen metriky
[párování / opatrovník]
   └─ Go backend: pár/rodina, report, bílý seznam, režim
```

## 3. Rizika (seřazeno)
1. **Ztracený fakt v přepisu** — partner nepřišel na sraz, protože apka vyhladila čas. Tvrdá metrika, test na každém buildu.
2. **Jednostranné použití** — jeden partner filtruje druhého bez jeho vědomí. Párový režim vyžaduje oba; jednostranně jen vlastní kouč + vlastní příchozí filtr, a ten nemění tón odesílatele navenek.
3. **iOS nemá příchozí filtr** — neslibovat; iOS verze = kouč + párování.
4. **False positives** u hoaxů (fáze 2) — schovaný vnuk zabije důvěru.
5. **Play policy** na SMS/notifikace — podat brzy, počítat s týdny.
6. Spark jako single point — fail-open.

## 4. První tři kroky (tento týden)
1. Repo `lioilsources/ThePill` s tímto souborem a `data/eval/README.md` (formát: `text, tone, text_soft, facts[]`).
2. Scénář rozhovoru pro páry (10 otázek) + oslovit 5 párů.
3. `pill-core` kostra v Go s `/classify` a `/soften`, few-shot prompt v češtině, `make eval` nad prázdným setem — aby bylo kam data nasypat.
