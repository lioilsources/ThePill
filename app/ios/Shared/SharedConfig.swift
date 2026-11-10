import Foundation

/// Nastavení sdílené mezi apkou (Runner) a klávesnicí (PillKeyboard) přes App Group.
/// Stejné klíče jako lib/src/shared_config.dart. Soubor patří do OBOU targetů.
enum SharedConfig {
  static let appGroup = "group.com.ol1n.thePill"
  static let keyServerURL = "server_url"
  static let keyCoachEnabled = "coach_enabled"
  static let keyToken = "token"

  static var defaults: UserDefaults { UserDefaults(suiteName: appGroup) ?? .standard }

  static var serverURL: String { defaults.string(forKey: keyServerURL) ?? "" }

  static var token: String { defaults.string(forKey: keyToken) ?? "" }

  static var coachEnabled: Bool {
    defaults.object(forKey: keyCoachEnabled) as? Bool ?? true
  }

  static func save(serverURL: String, coachEnabled: Bool, token: String) {
    defaults.set(serverURL, forKey: keyServerURL)
    defaults.set(token, forKey: keyToken)
    defaults.set(coachEnabled, forKey: keyCoachEnabled)
  }
}
