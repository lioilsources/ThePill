// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro => '发送之前，教练会在消息听起来带攻击性时提醒你，并给出两种更平和的说法。它不会自行发送或改写任何内容。';

  @override
  String get setupTitle => '启用键盘';

  @override
  String get setupStepEnable => '1. 设置 → 键盘 → 添加“The Pill”。';

  @override
  String get setupStepFullAccessIos =>
      '2. 在 iPhone 上开启“允许完全访问”。否则键盘无法联网，教练也无法工作。';

  @override
  String get setupStepSwitch => '3. 输入时切换到 The Pill（地球或键盘图标）。';

  @override
  String get openSettings => '打开键盘设置';

  @override
  String get privacyTitle => '你的文字会怎样处理';

  @override
  String get privacyBody =>
      '键盘仅为检查语气，才会把你正在输入的消息文字发送到 Pill 服务器。服务器不会保存，也不会记录。密码和银行卡号永远不会被发送——在这些输入框中，教练保持沉默。';

  @override
  String get serverTitle => '服务器';

  @override
  String get serverUrlLabel => 'pill-core 地址';

  @override
  String get tokenLabel => '访问令牌';

  @override
  String get tokenHint => '仅用于公共服务器，否则留空';

  @override
  String get serverUrlHint => 'http://<电脑 IP>:8090';

  @override
  String get coachEnabled => '已开启教练';

  @override
  String get save => '保存';

  @override
  String get saved => '已保存';

  @override
  String get tryTitle => '试用教练';

  @override
  String get tryHint => '输入一条你打算发送的消息…';

  @override
  String get tryButton => '检查';

  @override
  String get tryOk => '听起来不错。';

  @override
  String get tryUnavailable => '教练暂时不可用——消息将原样发送。';

  @override
  String get tryAlternatives => '换一种说法：';
}

/// The translations for Chinese, using the Han script (`zh_Hans`).
class AppLocalizationsZhHans extends AppLocalizationsZh {
  AppLocalizationsZhHans() : super('zh_Hans');

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro => '发送之前，教练会在消息听起来带攻击性时提醒你，并给出两种更平和的说法。它不会自行发送或改写任何内容。';

  @override
  String get setupTitle => '启用键盘';

  @override
  String get setupStepEnable => '1. 设置 → 键盘 → 添加“The Pill”。';

  @override
  String get setupStepFullAccessIos =>
      '2. 在 iPhone 上开启“允许完全访问”。否则键盘无法联网，教练也无法工作。';

  @override
  String get setupStepSwitch => '3. 输入时切换到 The Pill（地球或键盘图标）。';

  @override
  String get openSettings => '打开键盘设置';

  @override
  String get privacyTitle => '你的文字会怎样处理';

  @override
  String get privacyBody =>
      '键盘仅为检查语气，才会把你正在输入的消息文字发送到 Pill 服务器。服务器不会保存，也不会记录。密码和银行卡号永远不会被发送——在这些输入框中，教练保持沉默。';

  @override
  String get serverTitle => '服务器';

  @override
  String get serverUrlLabel => 'pill-core 地址';

  @override
  String get tokenLabel => '访问令牌';

  @override
  String get tokenHint => '仅用于公共服务器，否则留空';

  @override
  String get serverUrlHint => 'http://<电脑 IP>:8090';

  @override
  String get coachEnabled => '已开启教练';

  @override
  String get save => '保存';

  @override
  String get saved => '已保存';

  @override
  String get tryTitle => '试用教练';

  @override
  String get tryHint => '输入一条你打算发送的消息…';

  @override
  String get tryButton => '检查';

  @override
  String get tryOk => '听起来不错。';

  @override
  String get tryUnavailable => '教练暂时不可用——消息将原样发送。';

  @override
  String get tryAlternatives => '换一种说法：';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro => '傳送之前，教練會在訊息聽起來帶有攻擊性時提醒你，並提供兩種較平和的說法。它不會自行傳送或改寫任何內容。';

  @override
  String get setupTitle => '啟用鍵盤';

  @override
  String get setupStepEnable => '1. 設定 → 鍵盤 → 新增「The Pill」。';

  @override
  String get setupStepFullAccessIos =>
      '2. 在 iPhone 上開啟「允許完整取用」。否則鍵盤無法連網，教練也無法運作。';

  @override
  String get setupStepSwitch => '3. 輸入時切換到 The Pill（地球或鍵盤圖示）。';

  @override
  String get openSettings => '開啟鍵盤設定';

  @override
  String get privacyTitle => '你的文字會如何處理';

  @override
  String get privacyBody =>
      '鍵盤僅為檢查語氣，才會把你正在輸入的訊息文字傳送到 Pill 伺服器。伺服器不會儲存，也不會記錄。密碼和信用卡號絕不會被傳送——在這些欄位中，教練保持沉默。';

  @override
  String get serverTitle => '伺服器';

  @override
  String get serverUrlLabel => 'pill-core 位址';

  @override
  String get tokenLabel => '存取權杖';

  @override
  String get tokenHint => '僅用於公開伺服器，否則留空';

  @override
  String get serverUrlHint => 'http://<電腦 IP>:8090';

  @override
  String get coachEnabled => '已開啟教練';

  @override
  String get save => '儲存';

  @override
  String get saved => '已儲存';

  @override
  String get tryTitle => '試用教練';

  @override
  String get tryHint => '輸入一則你打算傳送的訊息…';

  @override
  String get tryButton => '檢查';

  @override
  String get tryOk => '聽起來不錯。';

  @override
  String get tryUnavailable => '教練目前無法使用——訊息將原樣傳送。';

  @override
  String get tryAlternatives => '換一種說法：';
}
