// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kannada (`kn`).
class AppLocalizationsKn extends AppLocalizations {
  AppLocalizationsKn([String locale = 'kn']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'ಕಳುಹಿಸುವ ಮೊದಲು ಸಂದೇಶ ದಾಳಿಯಂತೆ ಕೇಳಿಸಿದರೆ ಕೋಚ್ ಎಚ್ಚರಿಸಿ, ಇನ್ನೂ ಶಾಂತವಾದ ಎರಡು ರೂಪಗಳನ್ನು ಸೂಚಿಸುತ್ತದೆ. ಅದು ತಾನಾಗಿ ಏನನ್ನೂ ಕಳುಹಿಸುವುದಿಲ್ಲ, ಬದಲಿಸುವುದಿಲ್ಲ.';

  @override
  String get setupTitle => 'ಕೀಬೋರ್ಡ್ ಆನ್ ಮಾಡುವುದು';

  @override
  String get setupStepEnable =>
      '1. ಸೆಟ್ಟಿಂಗ್ಸ್ → ಕೀಬೋರ್ಡ್‌ಗಳು → «The Pill» ಸೇರಿಸಿ.';

  @override
  String get setupStepFullAccessIos =>
      '2. iPhone ನಲ್ಲಿ «ಪೂರ್ಣ ಪ್ರವೇಶಕ್ಕೆ ಅನುಮತಿಸಿ» ಆನ್ ಮಾಡಿ. ಅದಿಲ್ಲದೆ ಕೀಬೋರ್ಡ್‌ಗೆ ನೆಟ್‌ವರ್ಕ್ ಸಿಗುವುದಿಲ್ಲ, ಕೋಚ್ ಕೆಲಸ ಮಾಡುವುದಿಲ್ಲ.';

  @override
  String get setupStepSwitch =>
      '3. ಟೈಪ್ ಮಾಡುವಾಗ The Pill ಗೆ ಬದಲಿಸಿ (ಗ್ಲೋಬ್ ಅಥವಾ ಕೀಬೋರ್ಡ್ ಐಕಾನ್).';

  @override
  String get openSettings => 'ಕೀಬೋರ್ಡ್ ಸೆಟ್ಟಿಂಗ್ಸ್ ತೆರೆಯಿರಿ';

  @override
  String get privacyTitle => 'ನಿಮ್ಮ ಪಠ್ಯಕ್ಕೆ ಏನಾಗುತ್ತದೆ';

  @override
  String get privacyBody =>
      'ಕೀಬೋರ್ಡ್ ಧ್ವನಿಯನ್ನು ಪರಿಶೀಲಿಸಲು ಮಾತ್ರ ನೀವು ಬರೆಯುತ್ತಿರುವ ಸಂದೇಶದ ಪಠ್ಯವನ್ನು Pill ಸರ್ವರ್‌ಗೆ ಕಳುಹಿಸುತ್ತದೆ. ಸರ್ವರ್ ಅದನ್ನು ಉಳಿಸುವುದಿಲ್ಲ, ಲಾಗ್ ಮಾಡುವುದಿಲ್ಲ. ಪಾಸ್‌ವರ್ಡ್ ಮತ್ತು ಕಾರ್ಡ್ ಸಂಖ್ಯೆಗಳನ್ನು ಎಂದಿಗೂ ಕಳುಹಿಸುವುದಿಲ್ಲ — ಆ ಕ್ಷೇತ್ರಗಳಲ್ಲಿ ಕೋಚ್ ಮೌನವಾಗಿರುತ್ತದೆ.';

  @override
  String get serverTitle => 'ಸರ್ವರ್';

  @override
  String get serverUrlLabel => 'pill-core ವಿಳಾಸ';

  @override
  String get tokenLabel => 'ಪ್ರವೇಶ ಟೋಕನ್';

  @override
  String get tokenHint => 'ಸಾರ್ವಜನಿಕ ಸರ್ವರ್‌ಗೆ ಮಾತ್ರ, ಇಲ್ಲವಾದರೆ ಖಾಲಿ ಬಿಡಿ';

  @override
  String get serverUrlHint => 'http://<ಕಂಪ್ಯೂಟರ್‌ನ IP>:8090';

  @override
  String get coachEnabled => 'ಕೋಚ್ ಆನ್';

  @override
  String get save => 'ಉಳಿಸಿ';

  @override
  String get saved => 'ಉಳಿಸಲಾಗಿದೆ';

  @override
  String get tryTitle => 'ಕೋಚ್ ಪ್ರಯತ್ನಿಸಿ';

  @override
  String get tryHint => 'ನೀವು ಕಳುಹಿಸುವ ಸಂದೇಶ ಬರೆಯಿರಿ…';

  @override
  String get tryButton => 'ಪರಿಶೀಲಿಸಿ';

  @override
  String get tryOk => 'ಚೆನ್ನಾಗಿದೆ.';

  @override
  String get tryUnavailable =>
      'ಕೋಚ್ ಈಗ ಲಭ್ಯವಿಲ್ಲ — ಸಂದೇಶ ಬದಲಾವಣೆಯಿಲ್ಲದೆ ಹೋಗುತ್ತದೆ.';

  @override
  String get tryAlternatives => 'ಇದನ್ನು ಬೇರೆ ರೀತಿಯಲ್ಲಿ ಹೇಳಲು:';
}
