// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      '送信する前に、メッセージが攻撃的に聞こえるときはコーチが知らせ、より穏やかな言い方を2つ提案します。自分から送信したり書き換えたりすることはありません。';

  @override
  String get setupTitle => 'キーボードを有効にする';

  @override
  String get setupStepEnable => '1. 設定 → キーボード →「The Pill」を追加します。';

  @override
  String get setupStepFullAccessIos =>
      '2. iPhoneでは「フルアクセスを許可」をオンにします。オフだとキーボードがネットワークを使えず、コーチが動きません。';

  @override
  String get setupStepSwitch => '3. 入力中に The Pill に切り替えます（地球儀またはキーボードのアイコン）。';

  @override
  String get openSettings => 'キーボードの設定を開く';

  @override
  String get privacyTitle => 'テキストはどうなるか';

  @override
  String get privacyBody =>
      'キーボードは、トーンを確認するためだけに、入力中のメッセージのテキストを Pill サーバーに送ります。サーバーはテキストを保存も記録もしません。パスワードやカード番号は送られません。そのような欄ではコーチは何も言いません。';

  @override
  String get serverTitle => 'サーバー';

  @override
  String get serverUrlLabel => 'pill-core のアドレス';

  @override
  String get tokenLabel => 'アクセストークン';

  @override
  String get tokenHint => '公開サーバーの場合のみ。それ以外は空欄のまま';

  @override
  String get serverUrlHint => 'http://<パソコンのIP>:8090';

  @override
  String get coachEnabled => 'コーチをオンにする';

  @override
  String get save => '保存';

  @override
  String get saved => '保存しました';

  @override
  String get tryTitle => 'コーチを試す';

  @override
  String get tryHint => '送るつもりのメッセージを入力…';

  @override
  String get tryButton => 'チェック';

  @override
  String get tryOk => '問題なさそうです。';

  @override
  String get tryUnavailable => 'コーチは今使えません。メッセージはそのまま送信されます。';

  @override
  String get tryAlternatives => '別の言い方：';
}
