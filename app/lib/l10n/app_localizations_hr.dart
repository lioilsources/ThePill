// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Prije slanja trener te upozori kad poruka zvuči kao napad i ponudi dvije mirnije verzije. Ništa ne šalje niti prepisuje sam.';

  @override
  String get setupTitle => 'Uključivanje tipkovnice';

  @override
  String get setupStepEnable => '1. Postavke → Tipkovnice → dodaj »The Pill«.';

  @override
  String get setupStepFullAccessIos =>
      '2. Na iPhoneu uključi »Dopusti potpuni pristup«. Bez njega tipkovnica ne smije na mrežu i trener ne radi.';

  @override
  String get setupStepSwitch =>
      '3. Dok tipkaš, prebaci se na The Pill (ikona globusa ili tipkovnice).';

  @override
  String get openSettings => 'Otvori postavke tipkovnice';

  @override
  String get privacyTitle => 'Što se događa s tvojim tekstom';

  @override
  String get privacyBody =>
      'Tipkovnica šalje tekst poruke koju pišeš na Pill poslužitelj samo radi provjere tona. Poslužitelj ga ne sprema niti zapisuje. Lozinke i brojevi kartica nikad se ne šalju – u tim poljima trener šuti.';

  @override
  String get serverTitle => 'Poslužitelj';

  @override
  String get serverUrlLabel => 'Adresa pill-corea';

  @override
  String get tokenLabel => 'Pristupni token';

  @override
  String get tokenHint => 'samo za javni poslužitelj, inače ostavi prazno';

  @override
  String get serverUrlHint => 'http://<IP računala>:8090';

  @override
  String get coachEnabled => 'Trener uključen';

  @override
  String get save => 'Spremi';

  @override
  String get saved => 'Spremljeno';

  @override
  String get tryTitle => 'Isprobaj trenera';

  @override
  String get tryHint => 'Napiši poruku koju bi poslao/poslala…';

  @override
  String get tryButton => 'Provjeri';

  @override
  String get tryOk => 'Zvuči u redu.';

  @override
  String get tryUnavailable =>
      'Trener je trenutačno nedostupan – poruka bi otišla nepromijenjena.';

  @override
  String get tryAlternatives => 'Drugi način da to kažeš:';
}
