// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Kouč tě před odesláním upozorní, když zpráva zní jako útok, a nabídne dvě klidnější verze. Nic neodešle ani nepřepíše sám.';

  @override
  String get setupTitle => 'Zapnutí klávesnice';

  @override
  String get setupStepEnable =>
      '1. Nastavení → Klávesnice → přidej „The Pill“.';

  @override
  String get setupStepFullAccessIos =>
      '2. Na iPhonu zapni „Povolit plný přístup“. Bez něj klávesnice nesmí na síť a kouč nefunguje.';

  @override
  String get setupStepSwitch =>
      '3. Při psaní přepni na The Pill (ikona glóbu nebo klávesnice).';

  @override
  String get openSettings => 'Otevřít nastavení klávesnice';

  @override
  String get privacyTitle => 'Co se děje s textem';

  @override
  String get privacyBody =>
      'Klávesnice pošle text rozepsané zprávy na server Pilulky jen ke kontrole tónu. Server text neukládá ani neloguje. Hesla a čísla karet klávesnice nikdy neposílá — v těch polích kouč mlčí.';

  @override
  String get serverTitle => 'Server';

  @override
  String get serverUrlLabel => 'Adresa pill-core';

  @override
  String get tokenLabel => 'Přístupový token';

  @override
  String get tokenHint => 'jen pro veřejný server, jinak nech prázdné';

  @override
  String get serverUrlHint => 'http://<IP počítače>:8090';

  @override
  String get coachEnabled => 'Kouč zapnutý';

  @override
  String get save => 'Uložit';

  @override
  String get saved => 'Uloženo';

  @override
  String get tryTitle => 'Vyzkoušej kouče';

  @override
  String get tryHint => 'Napiš zprávu, kterou bys poslal(a)…';

  @override
  String get tryButton => 'Zkontrolovat';

  @override
  String get tryOk => 'Zní to v pohodě.';

  @override
  String get tryUnavailable =>
      'Kouč je teď nedostupný — zpráva by odešla beze změny.';

  @override
  String get tryAlternatives => 'Jak to říct jinak:';
}
