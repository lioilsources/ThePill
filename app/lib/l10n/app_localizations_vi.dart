// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Trước khi gửi, huấn luyện viên sẽ cảnh báo khi tin nhắn nghe như một đòn công kích và gợi ý hai phiên bản êm hơn. Nó không bao giờ tự gửi hay tự viết lại bất cứ điều gì.';

  @override
  String get setupTitle => 'Bật bàn phím';

  @override
  String get setupStepEnable => '1. Cài đặt → Bàn phím → thêm «The Pill».';

  @override
  String get setupStepFullAccessIos =>
      '2. Trên iPhone, hãy bật «Cho phép truy cập đầy đủ». Nếu không, bàn phím không thể ra mạng và huấn luyện viên sẽ không hoạt động.';

  @override
  String get setupStepSwitch =>
      '3. Khi gõ, hãy chuyển sang The Pill (biểu tượng quả địa cầu hoặc bàn phím).';

  @override
  String get openSettings => 'Mở cài đặt bàn phím';

  @override
  String get privacyTitle => 'Điều gì xảy ra với văn bản của bạn';

  @override
  String get privacyBody =>
      'Bàn phím chỉ gửi nội dung tin nhắn bạn đang gõ đến máy chủ Pill để kiểm tra giọng điệu. Máy chủ không lưu và không ghi nhật ký. Mật khẩu và số thẻ không bao giờ được gửi — ở các ô đó huấn luyện viên im lặng.';

  @override
  String get serverTitle => 'Máy chủ';

  @override
  String get serverUrlLabel => 'Địa chỉ pill-core';

  @override
  String get tokenLabel => 'Mã truy cập';

  @override
  String get tokenHint => 'chỉ cho máy chủ công khai, nếu không hãy để trống';

  @override
  String get serverUrlHint => 'http://<IP của máy tính>:8090';

  @override
  String get coachEnabled => 'Bật huấn luyện viên';

  @override
  String get save => 'Lưu';

  @override
  String get saved => 'Đã lưu';

  @override
  String get tryTitle => 'Thử huấn luyện viên';

  @override
  String get tryHint => 'Gõ một tin nhắn bạn định gửi…';

  @override
  String get tryButton => 'Kiểm tra';

  @override
  String get tryOk => 'Nghe ổn.';

  @override
  String get tryUnavailable =>
      'Huấn luyện viên hiện không khả dụng — tin nhắn sẽ được gửi nguyên văn.';

  @override
  String get tryAlternatives => 'Một cách khác để nói điều này:';
}
