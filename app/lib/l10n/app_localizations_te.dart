// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class AppLocalizationsTe extends AppLocalizations {
  AppLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'పంపే ముందు సందేశం దాడిలా వినిపిస్తే కోచ్ హెచ్చరించి రెండు ప్రశాంతమైన రూపాలను సూచిస్తుంది. అది తనంతట తానుగా ఏదీ పంపదు, మార్చి రాయదు.';

  @override
  String get setupTitle => 'కీబోర్డ్‌ను ఆన్ చేయడం';

  @override
  String get setupStepEnable =>
      '1. సెట్టింగ్‌లు → కీబోర్డ్‌లు → «The Pill» ను జోడించండి.';

  @override
  String get setupStepFullAccessIos =>
      '2. iPhone లో «పూర్తి యాక్సెస్‌ను అనుమతించు» ను ఆన్ చేయండి. అది లేకుంటే కీబోర్డ్ నెట్‌వర్క్‌ను వాడలేదు, కోచ్ పనిచేయదు.';

  @override
  String get setupStepSwitch =>
      '3. టైప్ చేసేటప్పుడు The Pill కు మారండి (గ్లోబ్ లేదా కీబోర్డ్ చిహ్నం).';

  @override
  String get openSettings => 'కీబోర్డ్ సెట్టింగ్‌లను తెరువు';

  @override
  String get privacyTitle => 'మీ టెక్స్ట్‌కు ఏమవుతుంది';

  @override
  String get privacyBody =>
      'స్వరాన్ని తనిఖీ చేయడానికి మాత్రమే, మీరు రాస్తున్న సందేశం టెక్స్ట్‌ను కీబోర్డ్ Pill సర్వర్‌కు పంపుతుంది. సర్వర్ దాన్ని నిల్వ చేయదు, లాగ్ చేయదు. పాస్‌వర్డ్‌లు, కార్డ్ నంబర్లు ఎప్పుడూ పంపబడవు — ఆ ఫీల్డ్‌లలో కోచ్ మౌనంగా ఉంటుంది.';

  @override
  String get serverTitle => 'సర్వర్';

  @override
  String get serverUrlLabel => 'pill-core చిరునామా';

  @override
  String get tokenLabel => 'యాక్సెస్ టోకెన్';

  @override
  String get tokenHint => 'పబ్లిక్ సర్వర్‌కు మాత్రమే, లేకపోతే ఖాళీగా ఉంచండి';

  @override
  String get serverUrlHint => 'http://<కంప్యూటర్ IP>:8090';

  @override
  String get coachEnabled => 'కోచ్ ఆన్';

  @override
  String get save => 'సేవ్ చేయి';

  @override
  String get saved => 'సేవ్ అయింది';

  @override
  String get tryTitle => 'కోచ్‌ను ప్రయత్నించండి';

  @override
  String get tryHint => 'మీరు పంపబోయే సందేశాన్ని రాయండి…';

  @override
  String get tryButton => 'తనిఖీ చేయి';

  @override
  String get tryOk => 'బాగానే ఉంది.';

  @override
  String get tryUnavailable =>
      'కోచ్ ప్రస్తుతం అందుబాటులో లేదు — సందేశం మార్పు లేకుండా వెళ్తుంది.';

  @override
  String get tryAlternatives => 'దీన్ని మరో విధంగా చెప్పడానికి:';
}
