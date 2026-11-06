# Zadání pro MacBook session — fáze 1b: klávesnice-kouč

Stav (6. 11. 2026, build na M2 se svolením uživatele): `flutter analyze` a `flutter test` čisté, Android `testDebugUnitTest` (3 testy) a `flutter build apk --debug` prošly, `flutter build ios --debug --no-codesign` prošel a `PillKeyboard.appex` je v apce. Na zařízení zatím nikdo nespouštěl — to je úkol téhle session: podpis, instalace, ruční test.

Repo: `lioilsources/ThePill`, složka `app/`. Nic z toho nepushuj bez potvrzení uživatele.

## 0. Příprava
```sh
git pull
cd app && flutter pub get && flutter analyze && flutter test
```

## 1. Android (nejdřív — nepotřebuje ruční zásahy)
```sh
cd app/android && ./gradlew :app:testDebugUnitTest   # CoachGateTest
cd .. && flutter build apk --debug
```
- Oprav případné chyby překladu v `android/app/src/main/kotlin/com/lioilsources/the_pill/` (PillKeyboardService, CoachClient, CoachGate, SharedConfig, MainActivity). Kotlin zatím nikdo nepřekládal.
- Nainstaluj na telefon, Nastavení → Systém → Klávesnice → zapni „The Pill“.

## 2. iOS — target klávesnice
Target `PillKeyboard` je už v `Runner.xcodeproj` (přidaný skriptem přes `xcodeproj`): zdrojáky,
`Shared/SharedConfig.swift` v obou targetech, lokalizace cs/en, Info.plist, entitlements s App Group
`group.com.ol1n.thePill`, a fáze „Embed Foundation Extensions“ je před „Thin Binary“.
Zbývá jen podpis:

1. `open app/ios/Runner.xcworkspace` → u Runner i PillKeyboard zvol Team (Signing & Capabilities).
2. App Group `group.com.ol1n.thePill` případně vytvoř v Developer portálu (Xcode to nabídne).
3. `flutter build ios --debug --no-codesign` pro kontrolu, pak spustit na zařízení.
4. Na iPhonu: Nastavení → Obecné → Klávesnice → Přidat → The Pill → zapnout **Povolit plný přístup**.

## 3. pill-core pro test na telefonu
`pill-core` zatím běží jen lokálně. Na M2 (nebo MacBooku) v kořeni repa:
```sh
cp .env.example .env   # doplň adresu Sparku v LAN (viz ~/.claude/shared/infra.md)
PILL_ADDR=0.0.0.0:8090 make run
```
- Model na Sparku musí běžet: `id=$(sparkctl lease thepill qwen36 60 10 "ThePill test klávesnice")`, během testu `sparkctl hb $id` aspoň každých 5 min, na konci `sparkctl done $id`.
- V apce vyplň adresu `http://<IP Macu v LAN>:8090` → Uložit. Pole „Vyzkoušej kouče“ ověří spojení.
- Debug Android povoluje HTTP (`src/debug/res/xml/network_security_config.xml`), iOS klávesnice má `NSAllowsLocalNetworking`. **[ověřit]**, zda ATS pustí holou IP adresu; pokud ne, použij `<hostname>.local`.

## 4. Ruční test (obě platformy)
| # | Kroky | Očekávám |
|---|---|---|
| 1 | V Messengeru/WhatsAppu napiš „KDE SAKRA JSOU KLÍČE OD AUTA“, počkej 2 s | lišta „Tohle zní jako útok — zobrazit jinak?“ |
| 2 | Zobrazit → tapni alternativu | celý text nahrazen alternativou, nic neodesláno |
| 3 | Napiš „Koupíš cestou mlíko? Díky“ | žádná lišta |
| 4 | Lišta je vidět, napiš další písmeno | lišta zmizí; nová kontrola po pauze |
| 5 | Pole pro heslo / číslo / e-mail | kouč mlčí (iOS do hesla klávesnici nepustí vůbec) |
| 6 | Zastav pill-core, napiš ostrou zprávu | žádná lišta, psaní funguje normálně (fail-open) |
| 7 | iOS bez plného přístupu | klávesnice píše, kouč mlčí |
| 8 | Kouč vypnutý v apce | žádná volání na server |
| 9 | Diakritika, čísla, shift, ⌫, 🌐, ↵ | píše správně; ↵ v Messengeru odešle jen tvým tapnutím |

## 5. Co nahlásit zpět
- Co bylo potřeba opravit v Kotlinu/Swiftu (commit na větev `macbook-1b`, PR do `main`).
- Výsledek tabulky výše, latence od pauzy po lištu, paměť klávesnice na iOS (limit extension).
- Screenshoty lišty a alternativ z obou platforem.
