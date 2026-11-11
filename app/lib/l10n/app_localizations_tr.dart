// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Göndermeden önce koç, bir mesaj saldırgan geliyorsa uyarır ve daha sakin iki sürüm önerir. Kendi başına hiçbir şey göndermez ya da yeniden yazmaz.';

  @override
  String get setupTitle => 'Klavyeyi etkinleştirme';

  @override
  String get setupStepEnable => '1. Ayarlar → Klavyeler → «The Pill» ekleyin.';

  @override
  String get setupStepFullAccessIos =>
      '2. iPhone\'da «Tam Erişime İzin Ver» seçeneğini açın. Bu olmadan klavye ağa çıkamaz ve koç çalışmaz.';

  @override
  String get setupStepSwitch =>
      '3. Yazarken The Pill\'e geçin (küre veya klavye simgesi).';

  @override
  String get openSettings => 'Klavye ayarlarını aç';

  @override
  String get privacyTitle => 'Metninize ne olur';

  @override
  String get privacyBody =>
      'Klavye, yazdığınız mesajın metnini yalnızca tonu denetlemek için Pill sunucusuna gönderir. Sunucu onu saklamaz ve kaydetmez. Parolalar ve kart numaraları hiçbir zaman gönderilmez; bu alanlarda koç sessiz kalır.';

  @override
  String get serverTitle => 'Sunucu';

  @override
  String get serverUrlLabel => 'pill-core adresi';

  @override
  String get tokenLabel => 'Erişim belirteci';

  @override
  String get tokenHint =>
      'yalnızca herkese açık sunucu için, aksi hâlde boş bırakın';

  @override
  String get serverUrlHint => 'http://<bilgisayarın IP\'si>:8090';

  @override
  String get coachEnabled => 'Koç açık';

  @override
  String get save => 'Kaydet';

  @override
  String get saved => 'Kaydedildi';

  @override
  String get tryTitle => 'Koçu deneyin';

  @override
  String get tryHint => 'Göndereceğiniz bir mesaj yazın…';

  @override
  String get tryButton => 'Denetle';

  @override
  String get tryOk => 'İyi görünüyor.';

  @override
  String get tryUnavailable =>
      'Koç şu anda kullanılamıyor; mesaj değişmeden gidecekti.';

  @override
  String get tryAlternatives => 'Bunu söylemenin başka bir yolu:';
}
