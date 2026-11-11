// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'לפני השליחה המאמן מזהיר כשהודעה נשמעת כמו התקפה ומציע שתי גרסאות רגועות יותר. הוא לא שולח ולא משכתב שום דבר מעצמו.';

  @override
  String get setupTitle => 'הפעלת המקלדת';

  @override
  String get setupStepEnable => '1. הגדרות ← מקלדות ← הוסף את «The Pill».';

  @override
  String get setupStepFullAccessIos =>
      '2. באייפון הפעל «אפשר גישה מלאה». בלעדיה המקלדת לא יכולה לגשת לרשת והמאמן לא עובד.';

  @override
  String get setupStepSwitch =>
      '3. בזמן ההקלדה עבור ל־The Pill (סמל הגלובוס או המקלדת).';

  @override
  String get openSettings => 'פתח את הגדרות המקלדת';

  @override
  String get privacyTitle => 'מה קורה לטקסט שלך';

  @override
  String get privacyBody =>
      'המקלדת שולחת את טקסט ההודעה שאתה מקליד לשרת Pill רק כדי לבדוק את הטון. השרת לא שומר אותו ולא רושם אותו ביומן. סיסמאות ומספרי כרטיס לא נשלחים לעולם — בשדות האלה המאמן שותק.';

  @override
  String get serverTitle => 'שרת';

  @override
  String get serverUrlLabel => 'כתובת pill-core';

  @override
  String get tokenLabel => 'אסימון גישה';

  @override
  String get tokenHint => 'רק לשרת ציבורי, אחרת השאר ריק';

  @override
  String get serverUrlHint => 'http://<כתובת IP של המחשב>:8090';

  @override
  String get coachEnabled => 'המאמן פועל';

  @override
  String get save => 'שמור';

  @override
  String get saved => 'נשמר';

  @override
  String get tryTitle => 'נסה את המאמן';

  @override
  String get tryHint => 'כתוב הודעה שהיית שולח…';

  @override
  String get tryButton => 'בדוק';

  @override
  String get tryOk => 'נשמע בסדר.';

  @override
  String get tryUnavailable => 'המאמן לא זמין כרגע — ההודעה תישלח ללא שינוי.';

  @override
  String get tryAlternatives => 'דרך אחרת לומר את זה:';
}
