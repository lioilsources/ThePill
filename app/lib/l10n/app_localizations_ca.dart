// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Abans d’enviar, el coach t’avisa quan un missatge sembla un atac i et proposa dues versions més tranquil·les. No envia ni reescriu res per si sol.';

  @override
  String get setupTitle => 'Activar el teclat';

  @override
  String get setupStepEnable => '1. Ajustos → Teclats → afegeix «The Pill».';

  @override
  String get setupStepFullAccessIos =>
      '2. A l’iPhone, activa «Permet l’accés complet». Sense això el teclat no pot accedir a la xarxa i el coach no funciona.';

  @override
  String get setupStepSwitch =>
      '3. Mentre escrius, canvia a The Pill (icona del globus o del teclat).';

  @override
  String get openSettings => 'Obre els ajustos del teclat';

  @override
  String get privacyTitle => 'Què passa amb el teu text';

  @override
  String get privacyBody =>
      'El teclat envia el text del missatge que escrius al servidor de Pill només per comprovar-ne el to. El servidor no el desa ni el registra. Les contrasenyes i els números de targeta no s’envien mai: en aquests camps el coach calla.';

  @override
  String get serverTitle => 'Servidor';

  @override
  String get serverUrlLabel => 'Adreça de pill-core';

  @override
  String get tokenLabel => 'Testimoni d’accés';

  @override
  String get tokenHint => 'només per a un servidor públic, si no deixa-ho buit';

  @override
  String get serverUrlHint => 'http://<IP de l’ordinador>:8090';

  @override
  String get coachEnabled => 'Coach activat';

  @override
  String get save => 'Desa';

  @override
  String get saved => 'Desat';

  @override
  String get tryTitle => 'Prova el coach';

  @override
  String get tryHint => 'Escriu un missatge que enviaries…';

  @override
  String get tryButton => 'Comprova';

  @override
  String get tryOk => 'Sona bé.';

  @override
  String get tryUnavailable =>
      'El coach no està disponible ara: el missatge s’enviaria sense canvis.';

  @override
  String get tryAlternatives => 'Una altra manera de dir-ho:';
}
