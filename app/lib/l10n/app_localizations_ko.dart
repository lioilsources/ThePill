// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      '보내기 전에 메시지가 공격적으로 들리면 코치가 알려 주고, 더 차분한 표현 두 가지를 제안해요. 스스로 보내거나 바꾸는 일은 없어요.';

  @override
  String get setupTitle => '키보드 켜기';

  @override
  String get setupStepEnable => '1. 설정 → 키보드 → 「The Pill」을 추가하세요.';

  @override
  String get setupStepFullAccessIos =>
      '2. iPhone에서는 「전체 접근 허용」을 켜세요. 켜지 않으면 키보드가 네트워크를 쓸 수 없어 코치가 작동하지 않아요.';

  @override
  String get setupStepSwitch => '3. 입력하는 중에 The Pill로 전환하세요(지구본 또는 키보드 아이콘).';

  @override
  String get openSettings => '키보드 설정 열기';

  @override
  String get privacyTitle => '내 글은 어떻게 처리되나요';

  @override
  String get privacyBody =>
      '키보드는 어조를 확인하려고 입력 중인 메시지의 글만 Pill 서버로 보내요. 서버는 그 글을 저장하거나 기록하지 않아요. 비밀번호와 카드 번호는 절대 보내지 않아요. 그런 입력란에서는 코치가 조용해요.';

  @override
  String get serverTitle => '서버';

  @override
  String get serverUrlLabel => 'pill-core 주소';

  @override
  String get tokenLabel => '액세스 토큰';

  @override
  String get tokenHint => '공개 서버에만 필요해요. 아니면 비워 두세요';

  @override
  String get serverUrlHint => 'http://<컴퓨터 IP>:8090';

  @override
  String get coachEnabled => '코치 켜기';

  @override
  String get save => '저장';

  @override
  String get saved => '저장됨';

  @override
  String get tryTitle => '코치 사용해 보기';

  @override
  String get tryHint => '보내려던 메시지를 입력해 보세요…';

  @override
  String get tryButton => '확인';

  @override
  String get tryOk => '괜찮게 들려요.';

  @override
  String get tryUnavailable => '지금은 코치를 쓸 수 없어요. 메시지는 그대로 전송돼요.';

  @override
  String get tryAlternatives => '이렇게 말해 볼 수 있어요:';
}
