// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Küldés előtt az edző szól, ha egy üzenet támadásnak hangzik, és két nyugodtabb változatot kínál. Magától semmit nem küld el és nem ír át.';

  @override
  String get setupTitle => 'A billentyűzet bekapcsolása';

  @override
  String get setupStepEnable =>
      '1. Beállítások → Billentyűzetek → add hozzá a „The Pill”-t.';

  @override
  String get setupStepFullAccessIos =>
      '2. iPhone-on kapcsold be a „Teljes hozzáférés engedélyezése” opciót. Enélkül a billentyűzet nem érheti el a hálózatot, és az edző nem működik.';

  @override
  String get setupStepSwitch =>
      '3. Gépelés közben válts a The Pillre (földgömb- vagy billentyűzetikon).';

  @override
  String get openSettings => 'Billentyűzet beállításai';

  @override
  String get privacyTitle => 'Mi történik a szöveggel';

  @override
  String get privacyBody =>
      'A billentyűzet a gépelt üzenet szövegét csak a hangnem ellenőrzésére küldi el a Pill szervernek. A szerver nem tárolja és nem naplózza. Jelszavakat és kártyaszámokat soha nem küld – ezekben a mezőkben az edző hallgat.';

  @override
  String get serverTitle => 'Szerver';

  @override
  String get serverUrlLabel => 'A pill-core címe';

  @override
  String get tokenLabel => 'Hozzáférési token';

  @override
  String get tokenHint => 'csak nyilvános szerverhez, különben hagyd üresen';

  @override
  String get serverUrlHint => 'http://<a számítógép IP-címe>:8090';

  @override
  String get coachEnabled => 'Edző bekapcsolva';

  @override
  String get save => 'Mentés';

  @override
  String get saved => 'Elmentve';

  @override
  String get tryTitle => 'Próbáld ki az edzőt';

  @override
  String get tryHint => 'Írj egy üzenetet, amit elküldenél…';

  @override
  String get tryButton => 'Ellenőrzés';

  @override
  String get tryOk => 'Jól hangzik.';

  @override
  String get tryUnavailable =>
      'Az edző most nem érhető el – az üzenet változatlanul menne el.';

  @override
  String get tryAlternatives => 'Így is mondhatod:';
}
