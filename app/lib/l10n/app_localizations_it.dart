// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Prima dell’invio il coach ti avvisa quando un messaggio suona come un attacco e propone due versioni più calme. Non invia né riscrive mai nulla da solo.';

  @override
  String get setupTitle => 'Attivare la tastiera';

  @override
  String get setupStepEnable =>
      '1. Impostazioni → Tastiere → aggiungi «The Pill».';

  @override
  String get setupStepFullAccessIos =>
      '2. Su iPhone attiva «Consenti accesso completo». Senza, la tastiera non può usare la rete e il coach non funziona.';

  @override
  String get setupStepSwitch =>
      '3. Mentre scrivi, passa a The Pill (icona del globo o della tastiera).';

  @override
  String get openSettings => 'Apri le impostazioni della tastiera';

  @override
  String get privacyTitle => 'Cosa succede al tuo testo';

  @override
  String get privacyBody =>
      'La tastiera invia il testo del messaggio che scrivi al server Pill solo per controllarne il tono. Il server non lo salva né lo registra. Password e numeri di carta non vengono mai inviati: in quei campi il coach tace.';

  @override
  String get serverTitle => 'Server';

  @override
  String get serverUrlLabel => 'Indirizzo di pill-core';

  @override
  String get tokenLabel => 'Token di accesso';

  @override
  String get tokenHint =>
      'solo per un server pubblico, altrimenti lascia vuoto';

  @override
  String get serverUrlHint => 'http://<IP del computer>:8090';

  @override
  String get coachEnabled => 'Coach attivo';

  @override
  String get save => 'Salva';

  @override
  String get saved => 'Salvato';

  @override
  String get tryTitle => 'Prova il coach';

  @override
  String get tryHint => 'Scrivi un messaggio che invieresti…';

  @override
  String get tryButton => 'Controlla';

  @override
  String get tryOk => 'Suona bene.';

  @override
  String get tryUnavailable =>
      'Il coach al momento non è disponibile: il messaggio partirebbe invariato.';

  @override
  String get tryAlternatives => 'Un altro modo per dirlo:';
}
