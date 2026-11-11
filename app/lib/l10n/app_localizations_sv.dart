// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Innan du skickar varnar tränaren när ett meddelande låter som ett angrepp och föreslår två lugnare versioner. Den skickar eller skriver aldrig om något på egen hand.';

  @override
  String get setupTitle => 'Aktivera tangentbordet';

  @override
  String get setupStepEnable =>
      '1. Inställningar → Tangentbord → lägg till ”The Pill”.';

  @override
  String get setupStepFullAccessIos =>
      '2. På iPhone slår du på ”Tillåt full åtkomst”. Utan den kommer tangentbordet inte ut på nätet och tränaren fungerar inte.';

  @override
  String get setupStepSwitch =>
      '3. Byt till The Pill medan du skriver (glob- eller tangentbordsikonen).';

  @override
  String get openSettings => 'Öppna tangentbordsinställningar';

  @override
  String get privacyTitle => 'Vad som händer med din text';

  @override
  String get privacyBody =>
      'Tangentbordet skickar texten i meddelandet du skriver till Pill-servern, bara för att kontrollera tonen. Servern lagrar eller loggar den inte. Lösenord och kortnummer skickas aldrig – i de fälten tiger tränaren.';

  @override
  String get serverTitle => 'Server';

  @override
  String get serverUrlLabel => 'Adress till pill-core';

  @override
  String get tokenLabel => 'Åtkomsttoken';

  @override
  String get tokenHint => 'bara för en offentlig server, annars lämna tomt';

  @override
  String get serverUrlHint => 'http://<datorns IP>:8090';

  @override
  String get coachEnabled => 'Tränare på';

  @override
  String get save => 'Spara';

  @override
  String get saved => 'Sparat';

  @override
  String get tryTitle => 'Testa tränaren';

  @override
  String get tryHint => 'Skriv ett meddelande du skulle skicka…';

  @override
  String get tryButton => 'Kontrollera';

  @override
  String get tryOk => 'Låter bra.';

  @override
  String get tryUnavailable =>
      'Tränaren är inte tillgänglig just nu – meddelandet skulle gå iväg oförändrat.';

  @override
  String get tryAlternatives => 'Ett annat sätt att säga det:';
}
