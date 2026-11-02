# EMOTIONS_PLAN.md — Emoční filtr na iOS a Androidu

> Handoff pro Director session. Projekt: **Stress Life** (mámy s dětmi do 5 let, filtr zpráv od partnera/rodiny) a **Death of Pill / Pilulka** (senioři, filtr hoaxů, nenávisti, deepfaků; v krajní podobě „odstřižení od reality").
> Stav platforem k 2. 11. 2026 (iOS 27, Android 16/17, EU DMA). Body označené **[ověřit]** před implementací zkontrolovat v aktuální dokumentaci.

---

## 0. Shrnutí v pěti větách

1. „Filtr na všechno" dnes nejde ani na jedné platformě — systém ti dá jen kanály, které si uživatel výslovně povolí.
2. **Android je hlavní platforma**: notification listener umí notifikace číst, *zrušit* a nahradit vlastní verzí; s rolí launcheru, SMS a call screening se dá pokrýt prakticky celý telefon seniora.
3. **iOS je skládačka okrajových kanálů** (share sheet, SMS od neznámých, Safari rozšíření, vlastní e-mailový klient, klávesnice) — plus EU-only cesta přes přeposílání notifikací na vlastní příslušenství.
4. On-device LLM od Apple/Google nestačí jako jediný mozek: Gemini Nano neběží na pozadí a Apple model neběží na starších iPhonech. Jádro = **vlastní malý klasifikátor** (distilovaný na Sparku), LLM jen na přepis v popředí.
5. Pořadí: Pilulka na Androidu (nejčistší hodnota, nejvíc přístupu) → Stress Life na Androidu → iOS kanály → EU accessory experiment.

---

## 1. Co filtr dělá (společné jádro obou apek)

**Vstup:** text zprávy + odesílatel + zdrojová apka + čas.
**Klasifikace (vždy na zařízení, na pozadí):**
- emoční tón: vztek, výčitka, nátlak/urgence, ironie, smutek, strach, neutrální, laskavost
- obsahové riziko (Pilulka): hoax/dezinformace, nenávist, podvod/scam, falešná urgence („babičko, potřebuju peníze"), podezřelý odkaz
- intenzita 0–1

**Pravidla uživatele** (zadává textem/hlasem, LLM je převede na strukturovaná pravidla):
- „od manžela nechci výčitky, jen co po mně chce" → per-sender pravidlo *přepsat na neutrální shrnutí*
- „po 20:00 nic negativního" → časové okno *odložit do rána*
- „hoaxy nikdy" → *karanténa*

**Akce:** propustit / přepsat (neutrální shrnutí, originál o klik dál) / odložit / karanténa / zahodit.

**Nepřekročitelné zásady (obě apky, i v „toxickém" režimu Pilulky):**
- **Nic se nemaže natrvalo** — vše jde do karantény, kterou lze prohlédnout.
- **Whitelist nouze**: vybrané kontakty (rodina, lékař) a urgentní signály („nemocnice", „nehoda", „volej hned") vždy projdou v originále.
- Bankovní/bezpečnostní upozornění se nikdy nepřepisují.
- Death of Pill má viditelný stav „jsi v režimu odstřižení" a jednoduchý exit — kvůli lidem i kvůli store review.

---

## 2. Android — hlavní platforma

### 2.1 Kanály a co umí

| Kanál | Co dá | Omezení |
|---|---|---|
| **NotificationListenerService** | Čte notifikace všech apek (WhatsApp, Messenger, SMS, e-mail…), umí `cancelNotification()` a apka pak postne vlastní filtrovanou verzi | Uživatel povolí v nastavení; od Androidu 15 jsou notifikace s OTP kódy pro „nedůvěryhodné" listenery skryté; u sideloadu blokováno „restricted settings", dokud to uživatel ručně nepovolí |
| **Default launcher (role HOME)** | Pilulka jako celé prostředí telefonu — senior vidí jen čistý feed a pár velkých tlačítek | Uživatel/rodina musí nastavit jako výchozí |
| **Default SMS app (role SMS)** | Plná kontrola nad SMS (hoaxy, scamy) — čtení i zobrazení | Play povolí SMS oprávnění jen výchozímu SMS handleru; apka musí být plnohodnotný SMS klient |
| **Call screening role** | Filtrace podvodných hovorů (senioři!) | Jen metadata hovoru, ne obsah |
| **AccessibilityService** | Čte celou obrazovku = opravdu „všechno" (feed Facebooku, web) | **Play to nepovolí** pro ne-accessibility apky → jen mimo Play (vlastní APK) |
| **Share sheet** | „Prožeň filtrem" cokoliv | Ruční |
| **IMAP / Graph** | Vlastní e-mailová schránka s filtrem | Gmail API s čtecími scopes = restricted scope → nákladný bezpečnostní audit (CASA) **[ověřit cenu 2026]**; Seznam/IMAP s heslem pro aplikace je nejlevnější start |

### 2.2 Distribuce
- **Google Play**: listener + launcher + SMS role + call screening. Bez Accessibility.
- **Mimo Play (APK „Pilulka Plus")**: + Accessibility. Google od 30. 9. 2026 vyžaduje ověřeného vývojáře i pro sideload (zatím BR/ID/SG/TH, globálně 2027) — Ol1n má ověřený organizační účet, takže OK. Na sideloadu ale uživatel musí projít „restricted settings" → vyžaduje asistovanou instalaci (rodina).

### 2.3 Modely na Androidu
- **Gemini Nano (ML Kit GenAI / Prompt API)**: jen novější vlajkové lodě a **inference jen v popředí** — na pozadí vrací chybu. → Použitelné pro přepis, když uživatel otevře zprávu, **ne** pro filtr v listeneru.
- **Vlastní klasifikátor (LiteRT/ONNX)**: malý multilingvní encoder (XLM-R / Czech BERT třída, ~50–150 MB, kvantizovaný) — běží na pozadí i na levných telefonech seniorů. Toto je jádro.
- **Přepis na levných telefonech**: šablonový přepis z klasifikace („Petr chce odpověď do pátku") + volitelně llama.cpp s malým modelem (Gemma 3 1B třída) **[ověřit výkon na low-end]**.

### 2.4 Rizika Android
- OEM baterie (Xiaomi, Samsung) zabíjí listener → onboarding „vypni optimalizaci baterie", foreground service.
- Restricted settings a Accessibility jsou přesně to, co dělá malware → v Play listingu a onboardingu extrémní transparentnost.
- Notifikace z WhatsAppu nesou jen zkrácený text — přepis dělat z toho, co přijde; plný text až při otevření originálu.

---

## 3. iOS — skládačka kanálů

Apple nedovolí žádné třetí straně číst notifikace ani obrazovku jiných apek (mimo EU accessory cestu níže). Co reálně jde:

| Kanál | Co dá | Pro koho | Omezení |
|---|---|---|---|
| **Share / Action extension** | Filtr na cokoliv, co uživatel sdílí | obě | Ruční |
| **Message Filter extension (IdentityLookup)** | Třídí SMS/MMS **od neznámých odesílatelů** do junk/transakce/promo | Pilulka (hoax a scam SMS) | Neumí přepsat, neumí iMessage od kontaktů |
| **Live Caller ID Lookup / Call Directory** | Označení podvodných čísel | Pilulka | Jen čísla |
| **Safari Web Extension** | Skrývá/přepisuje obsah webových stránek (zprávy, Facebook na webu) | Pilulka | Jen Safari |
| **Vlastní e-mailový klient (IMAP)** | Apka *je* schránka → plná kontrola + vlastní notifikace přes Notification Service Extension | obě | Uživatel musí přejít z Mail.app |
| **Klávesnice (Keyboard extension)** | **Filtr u odesílatele**: manžel si nainstaluje klávesnici, která mu před odesláním ukáže „tohle zní jako výčitka, nechceš to říct takhle?" | Stress Life (obrácená strana) | Tvrdý paměťový limit extension → jen malý klasifikátor, ne LLM; síť jen s „Plným přístupem" |
| **Screen Time API (FamilyControls/ManagedSettings)** | Blokace apek a webů v časových oknech — „detox" režim Death of Pill | Pilulka | Nutný entitlement od Apple; jen blokace, ne filtr obsahu |
| **Focus filters** | Chování vlastní apky podle zvoleného Focus režimu | obě | Jen vlastní apka |

**Modely na iOS 27:**
- **Foundation Models framework**: on-device model Apple Intelligence, v iOS 27 i s obrazovým vstupem, Private Cloud Compute (pro Small Business Program zdarma) a možností připojit vlastního LLM poskytovatele. Omezení: neběží na starších iPhonech, **čeština [ověřit]**, model se mění s verzí OS.
- **Core AI**: nový framework pro vlastní modely na Apple Silicon → sem patří vlastní klasifikátor (stejný jako na Androidu).

**Upřímně:** Stress Life na iPhonu (zprávy od manžela přes iMessage/WhatsApp) nejde filtrovat na straně příjemce. Reálné iOS varianty: share sheet, klávesnice na straně odesílatele, nebo EU accessory cesta.

### 3.1 EU-only: přeposílání notifikací na vlastní příslušenství (DMA)
Od iOS 26.3/26.5 v EU lze iOS notifikace přeposílat na příslušenství třetí strany přes **AccessoryNotifications + AccessoryTransportExtension**. Companion apka spáruje zařízení přes AccessorySetupKit, uživatel povolí přeposílání (všech/vybraných apek) a extension `AccessoryDataProvider` dostává obsah notifikací a „kurátoruje" ho pro zařízení.

**Příležitost:** „Pilulka" jako fyzické zařízení — e-ink/tablet displej pro seniora, kde se objeví jen to, co projde filtrem; iPhone může ležet v šuplíku. Pro Stress Life: náramek/displej, kde mámu nedostihne vztek, jen shrnutí.

**Omezení:**
- Jen zařízení v EU s EU Apple účtem; jen **jedno** zařízení najednou a vypíná přeposílání na Apple Watch.
- Licenční podmínky zakazují použít přeposlaná data k reklamě, profilování, **trénování modelů** a k šíření do jiných apek → klasifikace jen lokálně, žádné logy pro trénink. **Zda je emoční klasifikace „profilování" — ověřit s právníkem / Apple DTS.**
- Na iPhonu originální notifikace dál zůstávají — filtruje se jen to, co vidí příslušenství.
- Vyžaduje vlastní HW (ESP32 + displej, nebo starý Android tablet jako „příslušenství" **[ověřit, zda Apple akceptuje]**) a entitlement pro data provider.

---

## 4. Model a data (sdílené)

1. **Dataset**: české zprávy (vlastní syntetika + veřejné české sentiment/hate datasety + hoaxy z veřejných databází). Labely generuje velký model na DGX Sparku (teacher), ruční kontrola vzorku.
2. **Distilace** do malého encoderu (multi-label: tón + riziko + intenzita) → export LiteRT (Android) + Core AI/Core ML (iOS).
3. **Hoax DB**: server (Go, AiStack) publikuje podepsanou databázi hoaxů/scam vzorů; telefon ji jen stahuje — **žádná uživatelská data na server**.
4. **Přepis**: šablony z klasifikace všude; LLM přepis jen kde je k dispozici (Foundation Models / Gemini Nano v popředí / volitelně self-hosted s explicitním opt-inem).
5. **Evaluace**: sada 500 ručně označených českých zpráv; metrika hlavně *false negatives u nouze* (nesmí zmizet „jsem v nemocnici").

---

## 5. Architektura apky

- **Flutter**: UI, nastavení pravidel, karanténa, onboarding.
- **Nativní Kotlin**: NotificationListenerService, role (HOME/SMS/call screening), AccessibilityService (APK varianta), LiteRT inference.
- **Nativní Swift extensions**: Share, Message Filter, Safari Web Extension, Keyboard, Notification Service, (EU) AccessoryDataProvider.
- **Lokální úložiště**: šifrovaná SQLite (karanténa, pravidla, statistiky); sdílený App Group kontejner mezi iOS extensions.
- **Rodinný režim (Pilulka)**: dospělé dítě nastavuje pravidla a whitelist vzdáleně — E2E šifrovaná synchronizace jen *pravidel*, nikdy obsahu zpráv.
- **Backend (Go)**: jen hoax DB, aktualizace modelu, licence (Ol1n Pass). Žádný obsah.

---

## 6. Fáze

| Fáze | Obsah | Výstup |
|---|---|---|
| **F0 Spike (1–2 týdny)** | Dataset + první klasifikátor; Android listener prototyp: zachytit WhatsApp/SMS notifikaci → klasifikovat na pozadí → zrušit → postnout přepis; měřit latenci a baterii na levném telefonu | Go/no-go pro on-device klasifikaci |
| **F1 Pilulka Android (Play)** | Launcher + listener + SMS role + call screening + hoax DB + karanténa + rodinný režim | Beta pro 5–10 seniorů z okolí |
| **F2 Stress Life Android** | Per-sender pravidla, přepis na shrnutí, časová okna, denní „bezpečný souhrn" | Beta pro mámy |
| **F3 iOS kanály** | Share ext → Message Filter → Safari ext → IMAP klient → klávesnice pro odesílatele → Screen Time detox | iOS verze obou apek |
| **F4 Pilulka Plus (APK)** | Accessibility varianta mimo Play, asistovaná instalace | Pro rodiny, které chtějí „všechno" |
| **F5 EU accessory** | Prototyp ESP32/e-ink přijímače, právní ověření licenčních podmínek | Rozhodnutí, zda jít do HW |
| **Průběžně** | Sledovat WWDC (červen) a Android releasy — každé otevření API může změnit plán | |

---

## 7. Hlavní rizika a otevřené otázky

- **Store review**: název „Death of Pill" může u Apple i Google narazit (konotace sebepoškozování) → připravit alternativní název pro listing. **[ověřit]**
- **Privacy pozice**: emoční profil je extrémně citlivý; GDPR — držet vše na zařízení, žádná analytika obsahu. EU AI Act: textová analýza tónu pravděpodobně není „rozpoznávání emocí" ve smyslu biometrie, ale **[ověřit s právníkem]**.
- **Přecitlivělý filtr** = zmeškaná důležitá zpráva → whitelist nouze + karanténa + denní souhrn „co jsem ti schoval".
- **Etika Death of Pill**: produkt vědomě odstřihuje od reality; mít jasný exit, nouzový whitelist a viditelný stav.
- **OEM fragmentace Androidu** (baterie, listener).
- **Čeština** v Foundation Models a Gemini Nano. **[ověřit]**

---

## Zdroje
- EU notification forwarding (iOS 26.3): https://www.thurrott.com/apple/331005/ios-26-3-to-improve-interoperability-with-third-party-earbuds-and-smartwatches-in-the-eu
- Pravidla pro přeposlaná data: https://9to5mac.com/2026/03/30/apple-introduces-privacy-rules-for-third-party-access-to-notifications-and-live-activities/
- AccessoryNotifications: https://developer.apple.com/documentation/accessorynotifications
- AccessoryTransportExtension: https://developer.apple.com/documentation/accessorytransportextension
- iOS 27 Foundation Models / Core AI: https://developer.apple.com/wwdc26/guides/ios/ , https://techjacksolutions.com/ai-brief/apple-foundation-models-api-developers-ios-27-reported/
- ML Kit GenAI (zařízení, popředí): https://developers.google.com/ml-kit/genai
- Android 15 OTP v notifikacích: https://androidauthority.com/android-15-two-factor-authentication-codes-3492585
- Restricted settings pro sideload: https://9to5google.com/?p=640287
- Android developer verification: https://androidauthority.com/android-sideloading-developer-verification-first-wave-rollout-3717921
- iOS 26 filtrování zpráv: https://support.text-em-all.com/article/681-how-ios-26-message-filtering-may-affect-you-and-what-you-can-do-about-it
