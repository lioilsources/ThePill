// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Voor het versturen waarschuwt de coach je als een bericht klinkt als een aanval, en biedt hij twee rustigere versies aan. Hij verstuurt of herschrijft nooit iets uit zichzelf.';

  @override
  String get setupTitle => 'Het toetsenbord inschakelen';

  @override
  String get setupStepEnable =>
      '1. Instellingen → Toetsenborden → voeg „The Pill” toe.';

  @override
  String get setupStepFullAccessIos =>
      '2. Zet op de iPhone „Volledige toegang toestaan” aan. Zonder kan het toetsenbord het netwerk niet op en werkt de coach niet.';

  @override
  String get setupStepSwitch =>
      '3. Schakel tijdens het typen over naar The Pill (wereldbol- of toetsenbordpictogram).';

  @override
  String get openSettings => 'Toetsenbordinstellingen openen';

  @override
  String get privacyTitle => 'Wat er met je tekst gebeurt';

  @override
  String get privacyBody =>
      'Het toetsenbord stuurt de tekst van het bericht dat je typt alleen naar de Pill-server om de toon te controleren. De server slaat het niet op en logt het niet. Wachtwoorden en kaartnummers worden nooit verstuurd – in die velden zwijgt de coach.';

  @override
  String get serverTitle => 'Server';

  @override
  String get serverUrlLabel => 'Adres van pill-core';

  @override
  String get tokenLabel => 'Toegangstoken';

  @override
  String get tokenHint => 'alleen voor een openbare server, anders leeg laten';

  @override
  String get serverUrlHint => 'http://<IP van de computer>:8090';

  @override
  String get coachEnabled => 'Coach aan';

  @override
  String get save => 'Bewaren';

  @override
  String get saved => 'Bewaard';

  @override
  String get tryTitle => 'Probeer de coach';

  @override
  String get tryHint => 'Typ een bericht dat je zou versturen…';

  @override
  String get tryButton => 'Controleren';

  @override
  String get tryOk => 'Klinkt prima.';

  @override
  String get tryUnavailable =>
      'De coach is nu niet beschikbaar – het bericht zou ongewijzigd worden verstuurd.';

  @override
  String get tryAlternatives => 'Een andere manier om het te zeggen:';
}
