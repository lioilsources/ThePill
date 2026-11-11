// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Antes de enviar, el coach te avisa cuando un mensaje suena a ataque y te ofrece dos versiones más tranquilas. Nunca envía ni reescribe nada por su cuenta.';

  @override
  String get setupTitle => 'Activar el teclado';

  @override
  String get setupStepEnable => '1. Ajustes → Teclados → añade «The Pill».';

  @override
  String get setupStepFullAccessIos =>
      '2. En el iPhone, activa «Permitir acceso completo». Sin él el teclado no puede usar la red y el coach no funciona.';

  @override
  String get setupStepSwitch =>
      '3. Mientras escribes, cambia a The Pill (icono del globo o del teclado).';

  @override
  String get openSettings => 'Abrir ajustes del teclado';

  @override
  String get privacyTitle => 'Qué pasa con tu texto';

  @override
  String get privacyBody =>
      'El teclado envía el texto del mensaje que escribes al servidor de Pill solo para comprobar el tono. El servidor no lo guarda ni lo registra. Las contraseñas y los números de tarjeta nunca se envían: en esos campos el coach calla.';

  @override
  String get serverTitle => 'Servidor';

  @override
  String get serverUrlLabel => 'Dirección de pill-core';

  @override
  String get tokenLabel => 'Token de acceso';

  @override
  String get tokenHint => 'solo para un servidor público; si no, déjalo vacío';

  @override
  String get serverUrlHint => 'http://<IP del ordenador>:8090';

  @override
  String get coachEnabled => 'Coach activado';

  @override
  String get save => 'Guardar';

  @override
  String get saved => 'Guardado';

  @override
  String get tryTitle => 'Prueba el coach';

  @override
  String get tryHint => 'Escribe un mensaje que enviarías…';

  @override
  String get tryButton => 'Comprobar';

  @override
  String get tryOk => 'Suena bien.';

  @override
  String get tryUnavailable =>
      'El coach no está disponible ahora: el mensaje saldría sin cambios.';

  @override
  String get tryAlternatives => 'Otra forma de decirlo:';
}
