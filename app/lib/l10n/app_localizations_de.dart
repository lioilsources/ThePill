// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Vor dem Senden warnt dich der Coach, wenn eine Nachricht wie ein Angriff klingt, und bietet zwei ruhigere Fassungen an. Er sendet oder ändert nie etwas von allein.';

  @override
  String get setupTitle => 'Tastatur aktivieren';

  @override
  String get setupStepEnable =>
      '1. Einstellungen → Tastaturen → „The Pill“ hinzufügen.';

  @override
  String get setupStepFullAccessIos =>
      '2. Auf dem iPhone „Vollen Zugriff erlauben“ einschalten. Ohne ihn darf die Tastatur nicht ins Netz und der Coach funktioniert nicht.';

  @override
  String get setupStepSwitch =>
      '3. Beim Schreiben auf The Pill umschalten (Globus- oder Tastatursymbol).';

  @override
  String get openSettings => 'Tastatureinstellungen öffnen';

  @override
  String get privacyTitle => 'Was mit deinem Text passiert';

  @override
  String get privacyBody =>
      'Die Tastatur schickt den Text der Nachricht, die du tippst, nur zur Prüfung des Tons an den Pill-Server. Der Server speichert ihn nicht und schreibt ihn nicht ins Log. Passwörter und Kartennummern werden nie gesendet – in diesen Feldern schweigt der Coach.';

  @override
  String get serverTitle => 'Server';

  @override
  String get serverUrlLabel => 'Adresse von pill-core';

  @override
  String get tokenLabel => 'Zugriffstoken';

  @override
  String get tokenHint =>
      'nur für einen öffentlichen Server, sonst leer lassen';

  @override
  String get serverUrlHint => 'http://<IP des Computers>:8090';

  @override
  String get coachEnabled => 'Coach eingeschaltet';

  @override
  String get save => 'Speichern';

  @override
  String get saved => 'Gespeichert';

  @override
  String get tryTitle => 'Coach ausprobieren';

  @override
  String get tryHint => 'Schreib eine Nachricht, die du senden würdest…';

  @override
  String get tryButton => 'Prüfen';

  @override
  String get tryOk => 'Klingt gut.';

  @override
  String get tryUnavailable =>
      'Der Coach ist gerade nicht erreichbar – die Nachricht würde unverändert gesendet.';

  @override
  String get tryAlternatives => 'So kannst du es auch sagen:';
}
