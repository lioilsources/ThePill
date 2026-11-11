// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malayalam (`ml`).
class AppLocalizationsMl extends AppLocalizations {
  AppLocalizationsMl([String locale = 'ml']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'അയയ്ക്കുന്നതിന് മുമ്പ് സന്ദേശം ആക്രമണം പോലെ തോന്നിയാൽ കോച്ച് മുന്നറിയിപ്പ് തരികയും കൂടുതൽ ശാന്തമായ രണ്ട് രൂപങ്ങൾ നിർദ്ദേശിക്കുകയും ചെയ്യും. സ്വയം ഒന്നും അയയ്ക്കുകയോ മാറ്റിയെഴുതുകയോ ഇല്ല.';

  @override
  String get setupTitle => 'കീബോർഡ് ഓണാക്കൽ';

  @override
  String get setupStepEnable =>
      '1. ക്രമീകരണങ്ങൾ → കീബോർഡുകൾ → «The Pill» ചേർക്കുക.';

  @override
  String get setupStepFullAccessIos =>
      '2. iPhone-ൽ «പൂർണ്ണ ആക്സസ് അനുവദിക്കുക» ഓണാക്കുക. അതില്ലെങ്കിൽ കീബോർഡിന് നെറ്റ്‌വർക്ക് ഉപയോഗിക്കാനാവില്ല, കോച്ച് പ്രവർത്തിക്കില്ല.';

  @override
  String get setupStepSwitch =>
      '3. ടൈപ്പ് ചെയ്യുമ്പോൾ The Pill-ലേക്ക് മാറുക (ഗ്ലോബ് അല്ലെങ്കിൽ കീബോർഡ് ഐക്കൺ).';

  @override
  String get openSettings => 'കീബോർഡ് ക്രമീകരണങ്ങൾ തുറക്കുക';

  @override
  String get privacyTitle => 'നിങ്ങളുടെ ടെക്സ്റ്റിന് എന്ത് സംഭവിക്കുന്നു';

  @override
  String get privacyBody =>
      'സ്വരം പരിശോധിക്കാൻ മാത്രം, നിങ്ങൾ ടൈപ്പ് ചെയ്യുന്ന സന്ദേശത്തിന്റെ ടെക്സ്റ്റ് കീബോർഡ് Pill സെർവറിലേക്ക് അയയ്ക്കുന്നു. സെർവർ അത് സൂക്ഷിക്കുകയോ ലോഗ് ചെയ്യുകയോ ഇല്ല. പാസ്‌വേഡുകളും കാർഡ് നമ്പറുകളും ഒരിക്കലും അയയ്ക്കില്ല — ആ ഫീൽഡുകളിൽ കോച്ച് മൗനം പാലിക്കും.';

  @override
  String get serverTitle => 'സെർവർ';

  @override
  String get serverUrlLabel => 'pill-core വിലാസം';

  @override
  String get tokenLabel => 'ആക്സസ് ടോക്കൺ';

  @override
  String get tokenHint => 'പൊതു സെർവറിന് മാത്രം, അല്ലെങ്കിൽ ശൂന്യമായി വിടുക';

  @override
  String get serverUrlHint => 'http://<കമ്പ്യൂട്ടറിന്റെ IP>:8090';

  @override
  String get coachEnabled => 'കോച്ച് ഓൺ';

  @override
  String get save => 'സംരക്ഷിക്കുക';

  @override
  String get saved => 'സംരക്ഷിച്ചു';

  @override
  String get tryTitle => 'കോച്ചിനെ പരീക്ഷിക്കൂ';

  @override
  String get tryHint => 'നിങ്ങൾ അയയ്ക്കാനിരിക്കുന്ന സന്ദേശം എഴുതൂ…';

  @override
  String get tryButton => 'പരിശോധിക്കുക';

  @override
  String get tryOk => 'നന്നായിട്ടുണ്ട്.';

  @override
  String get tryUnavailable =>
      'കോച്ച് ഇപ്പോൾ ലഭ്യമല്ല — സന്ദേശം മാറ്റമില്ലാതെ പോകും.';

  @override
  String get tryAlternatives => 'ഇത് മറ്റൊരു രീതിയിൽ പറയാൻ:';
}
