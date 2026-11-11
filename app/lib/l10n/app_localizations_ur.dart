// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'بھیجنے سے پہلے کوچ خبردار کرتا ہے جب پیغام حملے جیسا لگے، اور دو پرسکون صورتیں تجویز کرتا ہے۔ وہ اپنے طور پر کچھ بھیجتا یا دوبارہ نہیں لکھتا۔';

  @override
  String get setupTitle => 'کی بورڈ آن کرنا';

  @override
  String get setupStepEnable => '۱۔ سیٹنگز ← کی بورڈز ← «The Pill» شامل کریں۔';

  @override
  String get setupStepFullAccessIos =>
      '۲۔ iPhone پر «مکمل رسائی کی اجازت دیں» آن کریں۔ اس کے بغیر کی بورڈ نیٹ ورک استعمال نہیں کر سکتا اور کوچ کام نہیں کرتا۔';

  @override
  String get setupStepSwitch =>
      '۳۔ ٹائپ کرتے وقت The Pill پر سوئچ کریں (گلوب یا کی بورڈ آئیکن)۔';

  @override
  String get openSettings => 'کی بورڈ سیٹنگز کھولیں';

  @override
  String get privacyTitle => 'آپ کے متن کے ساتھ کیا ہوتا ہے';

  @override
  String get privacyBody =>
      'کی بورڈ آپ کا لکھا ہوا پیغام صرف لہجہ جانچنے کے لیے Pill سرور کو بھیجتا ہے۔ سرور اسے محفوظ کرتا ہے نہ لاگ کرتا ہے۔ پاس ورڈ اور کارڈ نمبر کبھی نہیں بھیجے جاتے — ان خانوں میں کوچ خاموش رہتا ہے۔';

  @override
  String get serverTitle => 'سرور';

  @override
  String get serverUrlLabel => 'pill-core کا پتہ';

  @override
  String get tokenLabel => 'رسائی ٹوکن';

  @override
  String get tokenHint => 'صرف عوامی سرور کے لیے، ورنہ خالی چھوڑیں';

  @override
  String get serverUrlHint => 'http://<کمپیوٹر کا IP>:8090';

  @override
  String get coachEnabled => 'کوچ آن ہے';

  @override
  String get save => 'محفوظ کریں';

  @override
  String get saved => 'محفوظ ہو گیا';

  @override
  String get tryTitle => 'کوچ آزمائیں';

  @override
  String get tryHint => 'وہ پیغام لکھیں جو آپ بھیجنا چاہتے ہیں…';

  @override
  String get tryButton => 'جانچیں';

  @override
  String get tryOk => 'ٹھیک لگتا ہے۔';

  @override
  String get tryUnavailable =>
      'کوچ ابھی دستیاب نہیں — پیغام بغیر تبدیلی کے چلا جاتا۔';

  @override
  String get tryAlternatives => 'اسے کہنے کا ایک اور طریقہ:';
}
