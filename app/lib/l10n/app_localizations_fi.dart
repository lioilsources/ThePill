// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Ennen lähettämistä valmentaja varoittaa, kun viesti kuulostaa hyökkäykseltä, ja tarjoaa kaksi rauhallisempaa versiota. Se ei lähetä eikä kirjoita mitään uudelleen itse.';

  @override
  String get setupTitle => 'Näppäimistön käyttöönotto';

  @override
  String get setupStepEnable =>
      '1. Asetukset → Näppäimistöt → lisää ”The Pill”.';

  @override
  String get setupStepFullAccessIos =>
      '2. Ota iPhonessa käyttöön ”Salli täysi pääsy”. Ilman sitä näppäimistö ei pääse verkkoon eikä valmentaja toimi.';

  @override
  String get setupStepSwitch =>
      '3. Vaihda kirjoittaessa The Pilliin (maapallo- tai näppäimistökuvake).';

  @override
  String get openSettings => 'Avaa näppäimistön asetukset';

  @override
  String get privacyTitle => 'Mitä tekstillesi tapahtuu';

  @override
  String get privacyBody =>
      'Näppäimistö lähettää kirjoittamasi viestin tekstin Pill-palvelimelle vain sävyn tarkistamiseksi. Palvelin ei tallenna eikä kirjaa sitä. Salasanoja ja korttinumeroita ei koskaan lähetetä – näissä kentissä valmentaja on hiljaa.';

  @override
  String get serverTitle => 'Palvelin';

  @override
  String get serverUrlLabel => 'pill-coren osoite';

  @override
  String get tokenLabel => 'Käyttötunnus';

  @override
  String get tokenHint => 'vain julkiselle palvelimelle, muuten jätä tyhjäksi';

  @override
  String get serverUrlHint => 'http://<tietokoneen IP>:8090';

  @override
  String get coachEnabled => 'Valmentaja päällä';

  @override
  String get save => 'Tallenna';

  @override
  String get saved => 'Tallennettu';

  @override
  String get tryTitle => 'Kokeile valmentajaa';

  @override
  String get tryHint => 'Kirjoita viesti, jonka lähettäisit…';

  @override
  String get tryButton => 'Tarkista';

  @override
  String get tryOk => 'Kuulostaa hyvältä.';

  @override
  String get tryUnavailable =>
      'Valmentaja ei ole nyt käytettävissä – viesti lähtisi muuttumattomana.';

  @override
  String get tryAlternatives => 'Toinen tapa sanoa se:';
}
