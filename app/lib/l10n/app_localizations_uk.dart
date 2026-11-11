// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Перед надсиланням тренер попереджає, якщо повідомлення звучить як напад, і пропонує два спокійніші варіанти. Сам він нічого не надсилає і не переписує.';

  @override
  String get setupTitle => 'Увімкнення клавіатури';

  @override
  String get setupStepEnable =>
      '1. Налаштування → Клавіатури → додайте «The Pill».';

  @override
  String get setupStepFullAccessIos =>
      '2. На iPhone увімкніть «Дозволити повний доступ». Без цього клавіатура не вийде в мережу, і тренер не працюватиме.';

  @override
  String get setupStepSwitch =>
      '3. Під час набору перемкніться на The Pill (значок глобуса або клавіатури).';

  @override
  String get openSettings => 'Відкрити налаштування клавіатури';

  @override
  String get privacyTitle => 'Що відбувається з вашим текстом';

  @override
  String get privacyBody =>
      'Клавіатура надсилає текст повідомлення, яке ви набираєте, на сервер Pill лише для перевірки тону. Сервер його не зберігає й не журналює. Паролі та номери карток ніколи не надсилаються — у цих полях тренер мовчить.';

  @override
  String get serverTitle => 'Сервер';

  @override
  String get serverUrlLabel => 'Адреса pill-core';

  @override
  String get tokenLabel => 'Токен доступу';

  @override
  String get tokenHint =>
      'лише для публічного сервера, інакше залиште порожнім';

  @override
  String get serverUrlHint => 'http://<IP комп’ютера>:8090';

  @override
  String get coachEnabled => 'Тренер увімкнено';

  @override
  String get save => 'Зберегти';

  @override
  String get saved => 'Збережено';

  @override
  String get tryTitle => 'Спробуйте тренера';

  @override
  String get tryHint => 'Введіть повідомлення, яке б ви надіслали…';

  @override
  String get tryButton => 'Перевірити';

  @override
  String get tryOk => 'Звучить добре.';

  @override
  String get tryUnavailable =>
      'Тренер зараз недоступний — повідомлення пішло б без змін.';

  @override
  String get tryAlternatives => 'Інший спосіб сказати це:';
}
