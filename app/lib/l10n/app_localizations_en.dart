// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Before you send, the coach warns you when a message sounds like an attack and offers two calmer versions. It never sends or rewrites anything on its own.';

  @override
  String get setupTitle => 'Turning the keyboard on';

  @override
  String get setupStepEnable => '1. Settings → Keyboards → add “The Pill”.';

  @override
  String get setupStepFullAccessIos =>
      '2. On iPhone, turn on “Allow Full Access”. Without it the keyboard cannot use the network and the coach does not work.';

  @override
  String get setupStepSwitch =>
      '3. While typing, switch to The Pill (globe or keyboard icon).';

  @override
  String get openSettings => 'Open keyboard settings';

  @override
  String get privacyTitle => 'What happens to your text';

  @override
  String get privacyBody =>
      'The keyboard sends the message you are typing to the Pill server only to check its tone. The server does not store or log it. Passwords and card numbers are never sent — the coach stays silent in those fields.';

  @override
  String get serverTitle => 'Server';

  @override
  String get serverUrlLabel => 'pill-core address';

  @override
  String get tokenLabel => 'Access token';

  @override
  String get tokenHint => 'only for a public server, otherwise leave empty';

  @override
  String get serverUrlHint => 'http://<computer IP>:8090';

  @override
  String get coachEnabled => 'Coach on';

  @override
  String get save => 'Save';

  @override
  String get saved => 'Saved';

  @override
  String get tryTitle => 'Try the coach';

  @override
  String get tryHint => 'Type a message you would send…';

  @override
  String get tryButton => 'Check';

  @override
  String get tryOk => 'Sounds fine.';

  @override
  String get tryUnavailable =>
      'The coach is unavailable right now — the message would go out unchanged.';

  @override
  String get tryAlternatives => 'Another way to say it:';
}
