// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class AppLocalizationsSk extends AppLocalizations {
  AppLocalizationsSk([String locale = 'sk']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Pred odoslaním tréner upozorní, keď správa znie ako útok, a ponúkne dve pokojnejšie verzie. Sám nič neodosiela ani neprepisuje.';

  @override
  String get setupTitle => 'Zapnutie klávesnice';

  @override
  String get setupStepEnable =>
      '1. Nastavenia → Klávesnice → pridajte „The Pill“.';

  @override
  String get setupStepFullAccessIos =>
      '2. Na iPhone zapnite „Povoliť úplný prístup“. Bez neho sa klávesnica nedostane na sieť a tréner nefunguje.';

  @override
  String get setupStepSwitch =>
      '3. Pri písaní prepnite na The Pill (ikona glóbusu alebo klávesnice).';

  @override
  String get openSettings => 'Otvoriť nastavenia klávesnice';

  @override
  String get privacyTitle => 'Čo sa deje s vaším textom';

  @override
  String get privacyBody =>
      'Klávesnica odosiela text písanej správy na server Pill iba na kontrolu tónu. Server ho neukladá ani nezaznamenáva. Heslá a čísla kariet sa nikdy neodosielajú – v týchto poliach tréner mlčí.';

  @override
  String get serverTitle => 'Server';

  @override
  String get serverUrlLabel => 'Adresa pill-core';

  @override
  String get tokenLabel => 'Prístupový token';

  @override
  String get tokenHint => 'iba pre verejný server, inak nechajte prázdne';

  @override
  String get serverUrlHint => 'http://<IP počítača>:8090';

  @override
  String get coachEnabled => 'Tréner zapnutý';

  @override
  String get save => 'Uložiť';

  @override
  String get saved => 'Uložené';

  @override
  String get tryTitle => 'Vyskúšajte trénera';

  @override
  String get tryHint => 'Napíšte správu, ktorú by ste poslali…';

  @override
  String get tryButton => 'Skontrolovať';

  @override
  String get tryOk => 'Znie to dobre.';

  @override
  String get tryUnavailable =>
      'Tréner je teraz nedostupný – správa by odišla bez zmeny.';

  @override
  String get tryAlternatives => 'Iný spôsob, ako to povedať:';
}
