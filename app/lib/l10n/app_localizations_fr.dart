// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Avant l’envoi, le coach te prévient quand un message ressemble à une attaque et propose deux versions plus calmes. Il n’envoie ni ne réécrit jamais rien tout seul.';

  @override
  String get setupTitle => 'Activer le clavier';

  @override
  String get setupStepEnable => '1. Réglages → Claviers → ajoute « The Pill ».';

  @override
  String get setupStepFullAccessIos =>
      '2. Sur iPhone, active « Autoriser l’accès complet ». Sans cela, le clavier n’a pas accès au réseau et le coach ne fonctionne pas.';

  @override
  String get setupStepSwitch =>
      '3. Pendant la saisie, passe sur The Pill (icône globe ou clavier).';

  @override
  String get openSettings => 'Ouvrir les réglages du clavier';

  @override
  String get privacyTitle => 'Ce qui arrive à ton texte';

  @override
  String get privacyBody =>
      'Le clavier envoie le texte du message que tu écris au serveur Pill uniquement pour vérifier le ton. Le serveur ne le conserve pas et ne le journalise pas. Les mots de passe et numéros de carte ne sont jamais envoyés : dans ces champs, le coach reste muet.';

  @override
  String get serverTitle => 'Serveur';

  @override
  String get serverUrlLabel => 'Adresse de pill-core';

  @override
  String get tokenLabel => 'Jeton d’accès';

  @override
  String get tokenHint =>
      'uniquement pour un serveur public, sinon laisse vide';

  @override
  String get serverUrlHint => 'http://<IP de l’ordinateur>:8090';

  @override
  String get coachEnabled => 'Coach activé';

  @override
  String get save => 'Enregistrer';

  @override
  String get saved => 'Enregistré';

  @override
  String get tryTitle => 'Essayer le coach';

  @override
  String get tryHint => 'Écris un message que tu enverrais…';

  @override
  String get tryButton => 'Vérifier';

  @override
  String get tryOk => 'Ça sonne bien.';

  @override
  String get tryUnavailable =>
      'Le coach est indisponible pour le moment : le message partirait tel quel.';

  @override
  String get tryAlternatives => 'Une autre façon de le dire :';
}
