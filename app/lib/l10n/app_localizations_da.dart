// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Før du sender, advarer coachen dig, når en besked lyder som et angreb, og foreslår to roligere versioner. Den sender eller omskriver aldrig noget af sig selv.';

  @override
  String get setupTitle => 'Slå tastaturet til';

  @override
  String get setupStepEnable =>
      '1. Indstillinger → Tastaturer → tilføj »The Pill«.';

  @override
  String get setupStepFullAccessIos =>
      '2. På iPhone skal du slå »Tillad fuld adgang« til. Uden den kan tastaturet ikke bruge nettet, og coachen virker ikke.';

  @override
  String get setupStepSwitch =>
      '3. Skift til The Pill, mens du skriver (globus- eller tastaturikonet).';

  @override
  String get openSettings => 'Åbn tastaturindstillinger';

  @override
  String get privacyTitle => 'Hvad der sker med din tekst';

  @override
  String get privacyBody =>
      'Tastaturet sender teksten i den besked, du skriver, til Pill-serveren, kun for at tjekke tonen. Serveren gemmer eller logger den ikke. Adgangskoder og kortnumre sendes aldrig – i de felter tier coachen.';

  @override
  String get serverTitle => 'Server';

  @override
  String get serverUrlLabel => 'Adresse på pill-core';

  @override
  String get tokenLabel => 'Adgangstoken';

  @override
  String get tokenHint =>
      'kun til en offentlig server, ellers lad feltet stå tomt';

  @override
  String get serverUrlHint => 'http://<computerens IP>:8090';

  @override
  String get coachEnabled => 'Coach slået til';

  @override
  String get save => 'Gem';

  @override
  String get saved => 'Gemt';

  @override
  String get tryTitle => 'Prøv coachen';

  @override
  String get tryHint => 'Skriv en besked, du ville sende…';

  @override
  String get tryButton => 'Tjek';

  @override
  String get tryOk => 'Det lyder fint.';

  @override
  String get tryUnavailable =>
      'Coachen er ikke tilgængelig lige nu – beskeden ville gå uændret afsted.';

  @override
  String get tryAlternatives => 'En anden måde at sige det på:';
}
