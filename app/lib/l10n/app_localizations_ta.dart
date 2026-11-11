// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'அனுப்புவதற்கு முன் செய்தி தாக்குதல் போல ஒலித்தால் பயிற்சியாளர் எச்சரித்து இரண்டு அமைதியான வடிவங்களைப் பரிந்துரைக்கும். அது தானாக எதையும் அனுப்பவோ மாற்றி எழுதவோ செய்யாது.';

  @override
  String get setupTitle => 'விசைப்பலகையை இயக்குதல்';

  @override
  String get setupStepEnable =>
      '1. அமைப்புகள் → விசைப்பலகைகள் → «The Pill» ஐச் சேர்க்கவும்.';

  @override
  String get setupStepFullAccessIos =>
      '2. iPhone இல் «முழு அணுகலை அனுமதி» ஐ இயக்கவும். அது இல்லாமல் விசைப்பலகை பிணையத்தை அணுக முடியாது, பயிற்சியாளர் வேலை செய்யாது.';

  @override
  String get setupStepSwitch =>
      '3. தட்டச்சு செய்யும்போது The Pill க்கு மாறவும் (உலகம் அல்லது விசைப்பலகை படவுரு).';

  @override
  String get openSettings => 'விசைப்பலகை அமைப்புகளைத் திற';

  @override
  String get privacyTitle => 'உங்கள் உரைக்கு என்ன நடக்கிறது';

  @override
  String get privacyBody =>
      'தொனியைச் சரிபார்க்க மட்டும், நீங்கள் எழுதும் செய்தியின் உரையை விசைப்பலகை Pill சேவையகத்துக்கு அனுப்புகிறது. சேவையகம் அதைச் சேமிக்கவோ பதிவு செய்யவோ செய்யாது. கடவுச்சொற்களும் அட்டை எண்களும் ஒருபோதும் அனுப்பப்படாது — அந்தப் புலங்களில் பயிற்சியாளர் அமைதியாக இருக்கும்.';

  @override
  String get serverTitle => 'சேவையகம்';

  @override
  String get serverUrlLabel => 'pill-core முகவரி';

  @override
  String get tokenLabel => 'அணுகல் டோக்கன்';

  @override
  String get tokenHint =>
      'பொது சேவையகத்துக்கு மட்டும், இல்லையெனில் காலியாக விடவும்';

  @override
  String get serverUrlHint => 'http://<கணினியின் IP>:8090';

  @override
  String get coachEnabled => 'பயிற்சியாளர் இயக்கத்தில்';

  @override
  String get save => 'சேமி';

  @override
  String get saved => 'சேமிக்கப்பட்டது';

  @override
  String get tryTitle => 'பயிற்சியாளரை முயன்று பாருங்கள்';

  @override
  String get tryHint => 'நீங்கள் அனுப்ப இருக்கும் செய்தியை எழுதுங்கள்…';

  @override
  String get tryButton => 'சரிபார்';

  @override
  String get tryOk => 'நன்றாக ஒலிக்கிறது.';

  @override
  String get tryUnavailable =>
      'பயிற்சியாளர் இப்போது கிடைக்கவில்லை — செய்தி மாற்றமின்றிச் செல்லும்.';

  @override
  String get tryAlternatives => 'இதை வேறு விதமாகச் சொல்ல:';
}
