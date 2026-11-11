// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Przed wysłaniem trener ostrzega, gdy wiadomość brzmi jak atak, i proponuje dwie spokojniejsze wersje. Sam niczego nie wysyła ani nie przepisuje.';

  @override
  String get setupTitle => 'Włączanie klawiatury';

  @override
  String get setupStepEnable =>
      '1. Ustawienia → Klawiatury → dodaj „The Pill”.';

  @override
  String get setupStepFullAccessIos =>
      '2. Na iPhonie włącz „Zezwalaj na pełny dostęp”. Bez tego klawiatura nie wyjdzie do sieci i trener nie zadziała.';

  @override
  String get setupStepSwitch =>
      '3. Podczas pisania przełącz się na The Pill (ikona globu lub klawiatury).';

  @override
  String get openSettings => 'Otwórz ustawienia klawiatury';

  @override
  String get privacyTitle => 'Co dzieje się z Twoim tekstem';

  @override
  String get privacyBody =>
      'Klawiatura wysyła tekst pisanej wiadomości na serwer Pill wyłącznie po to, by sprawdzić jej ton. Serwer go nie zapisuje ani nie loguje. Hasła i numery kart nigdy nie są wysyłane – w tych polach trener milczy.';

  @override
  String get serverTitle => 'Serwer';

  @override
  String get serverUrlLabel => 'Adres pill-core';

  @override
  String get tokenLabel => 'Token dostępu';

  @override
  String get tokenHint =>
      'tylko dla serwera publicznego, w przeciwnym razie zostaw puste';

  @override
  String get serverUrlHint => 'http://<IP komputera>:8090';

  @override
  String get coachEnabled => 'Trener włączony';

  @override
  String get save => 'Zapisz';

  @override
  String get saved => 'Zapisano';

  @override
  String get tryTitle => 'Wypróbuj trenera';

  @override
  String get tryHint => 'Wpisz wiadomość, którą chciał(a)byś wysłać…';

  @override
  String get tryButton => 'Sprawdź';

  @override
  String get tryOk => 'Brzmi dobrze.';

  @override
  String get tryUnavailable =>
      'Trener jest teraz niedostępny – wiadomość zostałaby wysłana bez zmian.';

  @override
  String get tryAlternatives => 'Inny sposób, żeby to powiedzieć:';
}
