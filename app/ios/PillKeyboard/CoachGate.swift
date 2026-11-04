import UIKit

/// Kdy kouče volat — stejná pravidla jako CoachGate.kt na Androidu.
struct CoachGate {
  static let minChars = 12
  static let debounce: TimeInterval = 1.2

  private(set) var lastChecked: String?

  func shouldCheck(_ text: String, enabled: Bool, serverURL: String, sensitive: Bool, fullAccess: Bool) -> Bool {
    guard enabled, fullAccess, !sensitive, !serverURL.trimmingCharacters(in: .whitespaces).isEmpty else {
      return false
    }
    let t = text.trimmingCharacters(in: .whitespacesAndNewlines)
    return t.count >= Self.minChars && t != lastChecked
  }

  mutating func markChecked(_ text: String) {
    lastChecked = text.trimmingCharacters(in: .whitespacesAndNewlines)
  }

  mutating func reset() { lastChecked = nil }

  /// Hesla systém do vlastních klávesnic nepustí vůbec; číselná, telefonní, e-mailová a URL pole přeskakujeme.
  static func isSensitive(_ type: UIKeyboardType?) -> Bool {
    switch type {
    case .numberPad, .phonePad, .decimalPad, .asciiCapableNumberPad, .emailAddress, .URL, .webSearch, .namePhonePad:
      return true
    default:
      return false
    }
  }
}
