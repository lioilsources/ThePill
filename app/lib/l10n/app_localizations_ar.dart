// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'يحذّرك المدرّب قبل الإرسال عندما تبدو الرسالة كهجوم، ويقترح صيغتين أهدأ. لا يرسل شيئًا ولا يعيد كتابته من تلقاء نفسه.';

  @override
  String get setupTitle => 'تشغيل لوحة المفاتيح';

  @override
  String get setupStepEnable =>
      '1. الإعدادات ← لوحات المفاتيح ← أضف «The Pill».';

  @override
  String get setupStepFullAccessIos =>
      '2. على الآيفون فعّل «السماح بالوصول الكامل». بدونه لا تستطيع لوحة المفاتيح استخدام الشبكة ولا يعمل المدرّب.';

  @override
  String get setupStepSwitch =>
      '3. أثناء الكتابة بدّل إلى The Pill (أيقونة الكرة الأرضية أو لوحة المفاتيح).';

  @override
  String get openSettings => 'افتح إعدادات لوحة المفاتيح';

  @override
  String get privacyTitle => 'ماذا يحدث لنصّك';

  @override
  String get privacyBody =>
      'ترسل لوحة المفاتيح نص الرسالة التي تكتبها إلى خادم Pill لفحص نبرتها فقط. لا يخزّن الخادم النص ولا يسجّله. لا تُرسل كلمات المرور وأرقام البطاقات أبدًا، ويلتزم المدرّب الصمت في هذه الحقول.';

  @override
  String get serverTitle => 'الخادم';

  @override
  String get serverUrlLabel => 'عنوان pill-core';

  @override
  String get tokenLabel => 'رمز الوصول';

  @override
  String get tokenHint => 'للخادم العام فقط، وإلا اتركه فارغًا';

  @override
  String get serverUrlHint => 'http://<عنوان IP للكمبيوتر>:8090';

  @override
  String get coachEnabled => 'المدرّب مفعّل';

  @override
  String get save => 'حفظ';

  @override
  String get saved => 'تم الحفظ';

  @override
  String get tryTitle => 'جرّب المدرّب';

  @override
  String get tryHint => 'اكتب رسالة كنت سترسلها…';

  @override
  String get tryButton => 'افحص';

  @override
  String get tryOk => 'تبدو بخير.';

  @override
  String get tryUnavailable =>
      'المدرّب غير متاح الآن، وستُرسل الرسالة دون تغيير.';

  @override
  String get tryAlternatives => 'طريقة أخرى لقولها:';
}
