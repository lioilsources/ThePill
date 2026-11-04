import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    if let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "PillSharedConfig") {
      registerSharedConfigChannel(registrar.messenger())
    }
  }

  /// Flutter ↔ klávesnice: zápis do App Group, odkud čte PillKeyboard.
  private func registerSharedConfigChannel(_ messenger: FlutterBinaryMessenger) {
    let ch = FlutterMethodChannel(name: "thepill/shared_config", binaryMessenger: messenger)
    ch.setMethodCallHandler { call, result in
      switch call.method {
      case "load":
        result([
          SharedConfig.keyServerURL: SharedConfig.serverURL,
          SharedConfig.keyCoachEnabled: SharedConfig.coachEnabled,
        ])
      case "save":
        let args = call.arguments as? [String: Any] ?? [:]
        SharedConfig.save(
          serverURL: args[SharedConfig.keyServerURL] as? String ?? "",
          coachEnabled: args[SharedConfig.keyCoachEnabled] as? Bool ?? true)
        result(nil)
      case "openKeyboardSettings":
        // Nastavení apky; s nainstalovanou klávesnicí obsahuje položku Klávesnice.
        if let url = URL(string: UIApplication.openSettingsURLString) {
          UIApplication.shared.open(url)
        }
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }
}
