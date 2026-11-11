// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class AppLocalizationsGu extends AppLocalizations {
  AppLocalizationsGu([String locale = 'gu']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'મોકલતાં પહેલાં કોચ ચેતવે છે કે સંદેશ હુમલા જેવો લાગે છે અને બે શાંત રૂપ સૂચવે છે. તે જાતે કંઈ મોકલતો કે બદલતો નથી.';

  @override
  String get setupTitle => 'કીબોર્ડ ચાલુ કરવું';

  @override
  String get setupStepEnable => '1. સેટિંગ્સ → કીબોર્ડ → «The Pill» ઉમેરો.';

  @override
  String get setupStepFullAccessIos =>
      '2. iPhone પર «સંપૂર્ણ ઍક્સેસ મંજૂર કરો» ચાલુ કરો. તેના વિના કીબોર્ડ નેટવર્ક વાપરી શકતું નથી અને કોચ કામ કરતો નથી.';

  @override
  String get setupStepSwitch =>
      '3. લખતી વખતે The Pill પર સ્વિચ કરો (ગ્લોબ અથવા કીબોર્ડ આઇકન).';

  @override
  String get openSettings => 'કીબોર્ડ સેટિંગ્સ ખોલો';

  @override
  String get privacyTitle => 'તમારા લખાણનું શું થાય છે';

  @override
  String get privacyBody =>
      'કીબોર્ડ ફક્ત સૂર ચકાસવા માટે તમે લખતા સંદેશનું લખાણ Pill સર્વરને મોકલે છે. સર્વર તેને સાચવતું કે લૉગ કરતું નથી. પાસવર્ડ અને કાર્ડ નંબર ક્યારેય મોકલાતા નથી — તે ખાનાંમાં કોચ ચૂપ રહે છે.';

  @override
  String get serverTitle => 'સર્વર';

  @override
  String get serverUrlLabel => 'pill-core સરનામું';

  @override
  String get tokenLabel => 'ઍક્સેસ ટોકન';

  @override
  String get tokenHint => 'ફક્ત જાહેર સર્વર માટે, નહીંતર ખાલી રાખો';

  @override
  String get serverUrlHint => 'http://<કમ્પ્યુટરનું IP>:8090';

  @override
  String get coachEnabled => 'કોચ ચાલુ';

  @override
  String get save => 'સાચવો';

  @override
  String get saved => 'સાચવ્યું';

  @override
  String get tryTitle => 'કોચ અજમાવો';

  @override
  String get tryHint => 'તમે મોકલવાના હો તેવો સંદેશ લખો…';

  @override
  String get tryButton => 'તપાસો';

  @override
  String get tryOk => 'સારું લાગે છે.';

  @override
  String get tryUnavailable => 'કોચ હમણાં ઉપલબ્ધ નથી — સંદેશ બદલાયા વિના જશે.';

  @override
  String get tryAlternatives => 'બીજી રીતે કહેવા માટે:';
}
