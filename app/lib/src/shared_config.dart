import 'package:flutter/services.dart';

/// Nastavení sdílené s nativní klávesnicí.
/// Android: SharedPreferences „pill_shared“; iOS: App Group UserDefaults.
/// Obě strany čtou stejné klíče — viz PillKeyboardService.kt a SharedConfig.swift.
class PillConfig {
  const PillConfig({required this.serverUrl, required this.coachEnabled});

  final String serverUrl;
  final bool coachEnabled;

  static const empty = PillConfig(serverUrl: '', coachEnabled: true);
}

class SharedConfigStore {
  SharedConfigStore({MethodChannel? channel})
    : _ch = channel ?? const MethodChannel('thepill/shared_config');

  final MethodChannel _ch;

  static const keyServerUrl = 'server_url';
  static const keyCoachEnabled = 'coach_enabled';

  Future<PillConfig> load() async {
    try {
      final m = await _ch.invokeMapMethod<String, Object?>('load') ?? const {};
      return PillConfig(
        serverUrl: (m[keyServerUrl] as String?) ?? '',
        coachEnabled: (m[keyCoachEnabled] as bool?) ?? true,
      );
    } on MissingPluginException {
      return PillConfig.empty;
    }
  }

  Future<void> save(PillConfig c) async {
    await _ch.invokeMethod<void>('save', {
      keyServerUrl: c.serverUrl.trim(),
      keyCoachEnabled: c.coachEnabled,
    });
  }

  /// Otevře systémové nastavení klávesnic (Android) / nastavení apky (iOS).
  Future<void> openKeyboardSettings() async {
    try {
      await _ch.invokeMethod<void>('openKeyboardSettings');
    } on MissingPluginException {
      // v testech a na nepodporované platformě nic
    }
  }
}
