// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Antes de enviar, o coach avisa quando uma mensagem soa como ataque e sugere duas versões mais tranquilas. Ele nunca envia nem reescreve nada por conta própria.';

  @override
  String get setupTitle => 'Ativar o teclado';

  @override
  String get setupStepEnable => '1. Ajustes → Teclados → adicione «The Pill».';

  @override
  String get setupStepFullAccessIos =>
      '2. No iPhone, ative «Permitir acesso total». Sem isso o teclado não acessa a rede e o coach não funciona.';

  @override
  String get setupStepSwitch =>
      '3. Ao digitar, troque para o The Pill (ícone de globo ou de teclado).';

  @override
  String get openSettings => 'Abrir ajustes do teclado';

  @override
  String get privacyTitle => 'O que acontece com o seu texto';

  @override
  String get privacyBody =>
      'O teclado envia o texto da mensagem que você está escrevendo ao servidor do Pill só para verificar o tom. O servidor não o armazena nem registra. Senhas e números de cartão nunca são enviados — nesses campos o coach fica em silêncio.';

  @override
  String get serverTitle => 'Servidor';

  @override
  String get serverUrlLabel => 'Endereço do pill-core';

  @override
  String get tokenLabel => 'Token de acesso';

  @override
  String get tokenHint =>
      'só para servidor público; caso contrário, deixe em branco';

  @override
  String get serverUrlHint => 'http://<IP do computador>:8090';

  @override
  String get coachEnabled => 'Coach ativado';

  @override
  String get save => 'Salvar';

  @override
  String get saved => 'Salvo';

  @override
  String get tryTitle => 'Experimente o coach';

  @override
  String get tryHint => 'Digite uma mensagem que você enviaria…';

  @override
  String get tryButton => 'Verificar';

  @override
  String get tryOk => 'Soa bem.';

  @override
  String get tryUnavailable =>
      'O coach não está disponível agora — a mensagem seguiria sem alterações.';

  @override
  String get tryAlternatives => 'Outra forma de dizer isso:';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Antes de enviar, o coach avisa quando uma mensagem soa como ataque e sugere duas versões mais tranquilas. Ele nunca envia nem reescreve nada por conta própria.';

  @override
  String get setupTitle => 'Ativar o teclado';

  @override
  String get setupStepEnable => '1. Ajustes → Teclados → adicione «The Pill».';

  @override
  String get setupStepFullAccessIos =>
      '2. No iPhone, ative «Permitir acesso total». Sem isso o teclado não acessa a rede e o coach não funciona.';

  @override
  String get setupStepSwitch =>
      '3. Ao digitar, troque para o The Pill (ícone de globo ou de teclado).';

  @override
  String get openSettings => 'Abrir ajustes do teclado';

  @override
  String get privacyTitle => 'O que acontece com o seu texto';

  @override
  String get privacyBody =>
      'O teclado envia o texto da mensagem que você está escrevendo ao servidor do Pill só para verificar o tom. O servidor não o armazena nem registra. Senhas e números de cartão nunca são enviados — nesses campos o coach fica em silêncio.';

  @override
  String get serverTitle => 'Servidor';

  @override
  String get serverUrlLabel => 'Endereço do pill-core';

  @override
  String get tokenLabel => 'Token de acesso';

  @override
  String get tokenHint =>
      'só para servidor público; caso contrário, deixe em branco';

  @override
  String get serverUrlHint => 'http://<IP do computador>:8090';

  @override
  String get coachEnabled => 'Coach ativado';

  @override
  String get save => 'Salvar';

  @override
  String get saved => 'Salvo';

  @override
  String get tryTitle => 'Experimente o coach';

  @override
  String get tryHint => 'Digite uma mensagem que você enviaria…';

  @override
  String get tryButton => 'Verificar';

  @override
  String get tryOk => 'Soa bem.';

  @override
  String get tryUnavailable =>
      'O coach não está disponível agora — a mensagem seguiria sem alterações.';

  @override
  String get tryAlternatives => 'Outra forma de dizer isso:';
}

/// The translations for Portuguese, as used in Portugal (`pt_PT`).
class AppLocalizationsPtPt extends AppLocalizationsPt {
  AppLocalizationsPtPt() : super('pt_PT');

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Antes de enviar, o treinador avisa quando uma mensagem soa a ataque e sugere duas versões mais calmas. Nunca envia nem reescreve nada por iniciativa própria.';

  @override
  String get setupTitle => 'Ativar o teclado';

  @override
  String get setupStepEnable =>
      '1. Definições → Teclados → adicione «The Pill».';

  @override
  String get setupStepFullAccessIos =>
      '2. No iPhone, ative «Permitir acesso total». Sem isso o teclado não acede à rede e o treinador não funciona.';

  @override
  String get setupStepSwitch =>
      '3. Ao escrever, mude para o The Pill (ícone de globo ou de teclado).';

  @override
  String get openSettings => 'Abrir definições do teclado';

  @override
  String get privacyTitle => 'O que acontece ao seu texto';

  @override
  String get privacyBody =>
      'O teclado envia o texto da mensagem que está a escrever para o servidor do Pill apenas para verificar o tom. O servidor não o guarda nem regista. As palavras-passe e os números de cartão nunca são enviados — nesses campos o treinador fica em silêncio.';

  @override
  String get serverTitle => 'Servidor';

  @override
  String get serverUrlLabel => 'Endereço do pill-core';

  @override
  String get tokenLabel => 'Token de acesso';

  @override
  String get tokenHint =>
      'só para servidor público; caso contrário, deixe em branco';

  @override
  String get serverUrlHint => 'http://<IP do computador>:8090';

  @override
  String get coachEnabled => 'Treinador ativado';

  @override
  String get save => 'Guardar';

  @override
  String get saved => 'Guardado';

  @override
  String get tryTitle => 'Experimente o treinador';

  @override
  String get tryHint => 'Escreva uma mensagem que enviaria…';

  @override
  String get tryButton => 'Verificar';

  @override
  String get tryOk => 'Soa bem.';

  @override
  String get tryUnavailable =>
      'O treinador não está disponível neste momento — a mensagem seguiria sem alterações.';

  @override
  String get tryAlternatives => 'Outra forma de dizer isto:';
}
