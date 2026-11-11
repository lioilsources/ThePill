// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Înainte de trimitere, antrenorul te avertizează când un mesaj sună ca un atac și propune două variante mai calme. Nu trimite și nu rescrie nimic de capul lui.';

  @override
  String get setupTitle => 'Activarea tastaturii';

  @override
  String get setupStepEnable => '1. Setări → Tastaturi → adaugă «The Pill».';

  @override
  String get setupStepFullAccessIos =>
      '2. Pe iPhone, activează «Permite acces complet». Fără el tastatura nu poate accesa rețeaua, iar antrenorul nu funcționează.';

  @override
  String get setupStepSwitch =>
      '3. În timp ce scrii, comută pe The Pill (pictograma glob sau tastatură).';

  @override
  String get openSettings => 'Deschide setările tastaturii';

  @override
  String get privacyTitle => 'Ce se întâmplă cu textul tău';

  @override
  String get privacyBody =>
      'Tastatura trimite textul mesajului pe care îl scrii către serverul Pill doar pentru a verifica tonul. Serverul nu îl stochează și nu îl înregistrează. Parolele și numerele de card nu sunt trimise niciodată — în aceste câmpuri antrenorul tace.';

  @override
  String get serverTitle => 'Server';

  @override
  String get serverUrlLabel => 'Adresa pill-core';

  @override
  String get tokenLabel => 'Token de acces';

  @override
  String get tokenHint => 'doar pentru un server public, altfel lasă gol';

  @override
  String get serverUrlHint => 'http://<IP-ul calculatorului>:8090';

  @override
  String get coachEnabled => 'Antrenor activat';

  @override
  String get save => 'Salvează';

  @override
  String get saved => 'Salvat';

  @override
  String get tryTitle => 'Încearcă antrenorul';

  @override
  String get tryHint => 'Scrie un mesaj pe care l-ai trimite…';

  @override
  String get tryButton => 'Verifică';

  @override
  String get tryOk => 'Sună bine.';

  @override
  String get tryUnavailable =>
      'Antrenorul nu este disponibil acum — mesajul ar pleca nemodificat.';

  @override
  String get tryAlternatives => 'Un alt mod de a spune asta:';
}
