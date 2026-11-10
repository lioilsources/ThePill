# Release — TestFlight + Firebase App Tester + olin.now

Pipeline je z Distribution (`align-project.sh`, golden `Distribution/workflows/`):
`ci.yml` (Flutter + navíc Go `pill-core`), `release-ios.yml`, `release-android.yml`.
Release spouští tag `v*` (`git tag v0.1.0 && git push origin v0.1.0`); verze se bere z tagu.

| | |
|---|---|
| iOS bundle | `com.ol1n.thePill` |
| klávesnice | `com.ol1n.thePill.PillKeyboard` (app extension) |
| App Group | `group.com.ol1n.thePill` (apka i klávesnice) |
| Android | `com.ol1n.thePill` |

## Odchylka od golden šablony
`release-ios.yml` navíc instaluje **druhý profil** pro klávesnici (secret
`IOS_EXT_PROVISION_PROFILE_BASE64`), dosadí jeho UUID za `CI_EXT_PROFILE_NAME` v Release
konfiguraci targetu PillKeyboard a přidá ho do `ExportOptions.plist`. Golden šablona umí
jen jeden profil. Při `align-project.sh` znovu tyhle bloky zkontroluj, skript je přepíše.

## Jednou ručně (účty, ~20 min)
Postup a pasti: `Distribution/SKILL.md`. Pro ThePill navíc:

1. **Apple Developer → Identifiers**
   - App Group `group.com.ol1n.thePill`
   - App ID `com.ol1n.thePill`, capability **App Groups** → ta skupina
   - App ID `com.ol1n.thePill.PillKeyboard`, capability **App Groups** → ta skupina
2. **Profiles** (Distribution → App Store), dva:
   - `ThePill AppStore` → `Distribution/Apple/ThePill/ThePill_AppStore.mobileprovision`
   - `ThePill Keyboard AppStore` → `Distribution/Apple/ThePill/extensions/PillKeyboard.mobileprovision`
     (do podsložky — `setup-gh-secrets.sh` bere první `*.mobileprovision` ve složce appky)
3. **App Store Connect** → New App: iOS, bundle `com.ol1n.thePill`, SKU `ol1nthepill`,
   jméno v listingu „The Pill – klid v rodině“ (žádná smrt ani zombie navenek).
4. **Firebase** → Android app `com.ol1n.thePill` → `google-services.json` do
   `Distribution/Android/ThePill/` (podle `Distribution/SKILL.md` krok 3).
5. Secrets:
   ```sh
   cd Distribution && ./scripts/setup-gh-secrets.sh --repo lioilsources/ThePill
   base64 < Apple/ThePill/extensions/PillKeyboard.mobileprovision \
     | gh secret set IOS_EXT_PROVISION_PROFILE_BASE64 --repo lioilsources/ThePill
   ```
   A ruční opravy z `Distribution/CLAUDE.md` (Issuer ID, názvy ASC secretů).

## Server pro release buildy
Release build povoluje jen HTTPS (`network_security_config`), HTTP na `pill-core`
v LAN umí jen debug. Testeři z Firebase / TestFlightu potřebují `pill-core` za HTTPS
(Caddy). Než bude, testuj debug APK přes `adb install`.

`deploy/joda/deploy.sh` (vzor AlienMatch): `pill-core` + Caddy + vlastní Cloudflare tunnel
`thepill` na `pill.ol1n.com` (`PILL_HOST` přepíše). Idempotentní: `.env` s náhodným
`PILL_TOKEN`, tunnel i DNS vzniknou na JODĚ při prvním běhu a nikdy ji neopustí.
Appka posílá token jako `Authorization: Bearer` (pole „Přístupový token“).
Veřejný krok — spouštět jen na Olinovo „nasaď“.

LLM: stálá route na SPARKu není (broker přepíná profily). Klíč LiteLLM per projekt vydá
Olin a zapíše se do `.env` na JODĚ; bez něj `pill-core` degraduje (kouč mlčí). Timeout
10 s. Dostupnost ověřuj skutečným chat voláním, `/v1/models` lže. GPU okno pro
testovací den: `sparkctl lease` z vlastní session.

## Privacy / support
GitHub Pages z `main /docs`: `https://lioilsources.github.io/ThePill/privacy.html`,
`…/support.html` (do ASC a Google Play). Marketing URL `https://olin.now/thepill`.

## Po vydání
- olin.now: `apps/thepill/meta.md` → doplnit `testflight:` / `artifacts:` a screenshoty,
  `make fetch build`, PR, po merge `make deploy` (skill `release-flutter`).
