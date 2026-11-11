// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Før du sender, advarer treneren deg når en melding høres ut som et angrep, og foreslår to roligere versjoner. Den sender eller skriver aldri om noe av seg selv.';

  @override
  String get setupTitle => 'Slå på tastaturet';

  @override
  String get setupStepEnable =>
      '1. Innstillinger → Tastaturer → legg til «The Pill».';

  @override
  String get setupStepFullAccessIos =>
      '2. På iPhone må du slå på «Tillat full tilgang». Uten den kommer ikke tastaturet på nett, og treneren virker ikke.';

  @override
  String get setupStepSwitch =>
      '3. Bytt til The Pill mens du skriver (globus- eller tastaturikonet).';

  @override
  String get openSettings => 'Åpne tastaturinnstillinger';

  @override
  String get privacyTitle => 'Hva som skjer med teksten din';

  @override
  String get privacyBody =>
      'Tastaturet sender teksten i meldingen du skriver til Pill-serveren, bare for å sjekke tonen. Serveren lagrer eller logger den ikke. Passord og kortnumre sendes aldri – i de feltene tier treneren.';

  @override
  String get serverTitle => 'Server';

  @override
  String get serverUrlLabel => 'Adresse til pill-core';

  @override
  String get tokenLabel => 'Tilgangstoken';

  @override
  String get tokenHint =>
      'bare for en offentlig server, ellers la feltet stå tomt';

  @override
  String get serverUrlHint => 'http://<IP-adressen til datamaskinen>:8090';

  @override
  String get coachEnabled => 'Trener på';

  @override
  String get save => 'Lagre';

  @override
  String get saved => 'Lagret';

  @override
  String get tryTitle => 'Prøv treneren';

  @override
  String get tryHint => 'Skriv en melding du ville sendt…';

  @override
  String get tryButton => 'Sjekk';

  @override
  String get tryOk => 'Høres bra ut.';

  @override
  String get tryUnavailable =>
      'Treneren er ikke tilgjengelig akkurat nå – meldingen ville gått uendret.';

  @override
  String get tryAlternatives => 'En annen måte å si det på:';
}
