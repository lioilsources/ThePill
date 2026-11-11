// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Перед отправкой тренер предупреждает, если сообщение звучит как нападение, и предлагает два более спокойных варианта. Сам он ничего не отправляет и не переписывает.';

  @override
  String get setupTitle => 'Включение клавиатуры';

  @override
  String get setupStepEnable =>
      '1. Настройки → Клавиатуры → добавьте «The Pill».';

  @override
  String get setupStepFullAccessIos =>
      '2. На iPhone включите «Разрешить полный доступ». Без него клавиатура не выйдет в сеть, и тренер не будет работать.';

  @override
  String get setupStepSwitch =>
      '3. Во время набора переключитесь на The Pill (значок глобуса или клавиатуры).';

  @override
  String get openSettings => 'Открыть настройки клавиатуры';

  @override
  String get privacyTitle => 'Что происходит с вашим текстом';

  @override
  String get privacyBody =>
      'Клавиатура отправляет текст набираемого сообщения на сервер Pill только для проверки тона. Сервер его не хранит и не журналирует. Пароли и номера карт никогда не отправляются — в этих полях тренер молчит.';

  @override
  String get serverTitle => 'Сервер';

  @override
  String get serverUrlLabel => 'Адрес pill-core';

  @override
  String get tokenLabel => 'Токен доступа';

  @override
  String get tokenHint =>
      'только для публичного сервера, иначе оставьте пустым';

  @override
  String get serverUrlHint => 'http://<IP компьютера>:8090';

  @override
  String get coachEnabled => 'Тренер включён';

  @override
  String get save => 'Сохранить';

  @override
  String get saved => 'Сохранено';

  @override
  String get tryTitle => 'Попробуйте тренера';

  @override
  String get tryHint => 'Введите сообщение, которое вы бы отправили…';

  @override
  String get tryButton => 'Проверить';

  @override
  String get tryOk => 'Звучит нормально.';

  @override
  String get tryUnavailable =>
      'Тренер сейчас недоступен — сообщение ушло бы без изменений.';

  @override
  String get tryAlternatives => 'Другой способ сказать это:';
}
