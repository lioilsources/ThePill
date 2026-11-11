// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class AppLocalizationsSl extends AppLocalizations {
  AppLocalizationsSl([String locale = 'sl']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Pred pošiljanjem trener opozori, ko sporočilo zveni kot napad, in predlaga dve mirnejši različici. Sam nikoli ničesar ne pošlje ali prepiše.';

  @override
  String get setupTitle => 'Vklop tipkovnice';

  @override
  String get setupStepEnable =>
      '1. Nastavitve → Tipkovnice → dodajte »The Pill«.';

  @override
  String get setupStepFullAccessIos =>
      '2. V iPhonu vklopite »Dovoli poln dostop«. Brez tega tipkovnica ne more v omrežje in trener ne deluje.';

  @override
  String get setupStepSwitch =>
      '3. Med tipkanjem preklopite na The Pill (ikona globusa ali tipkovnice).';

  @override
  String get openSettings => 'Odpri nastavitve tipkovnice';

  @override
  String get privacyTitle => 'Kaj se zgodi z vašim besedilom';

  @override
  String get privacyBody =>
      'Tipkovnica pošlje besedilo sporočila, ki ga pišete, strežniku Pill samo za preverjanje tona. Strežnik ga ne shranjuje in ne beleži. Gesla in številke kartic se nikoli ne pošljejo – v teh poljih trener molči.';

  @override
  String get serverTitle => 'Strežnik';

  @override
  String get serverUrlLabel => 'Naslov pill-core';

  @override
  String get tokenLabel => 'Dostopni žeton';

  @override
  String get tokenHint => 'samo za javni strežnik, sicer pustite prazno';

  @override
  String get serverUrlHint => 'http://<IP računalnika>:8090';

  @override
  String get coachEnabled => 'Trener vklopljen';

  @override
  String get save => 'Shrani';

  @override
  String get saved => 'Shranjeno';

  @override
  String get tryTitle => 'Preizkusite trenerja';

  @override
  String get tryHint => 'Napišite sporočilo, ki bi ga poslali…';

  @override
  String get tryButton => 'Preveri';

  @override
  String get tryOk => 'Zveni dobro.';

  @override
  String get tryUnavailable =>
      'Trener trenutno ni na voljo – sporočilo bi odšlo nespremenjeno.';

  @override
  String get tryAlternatives => 'Drug način, kako to povedati:';
}
