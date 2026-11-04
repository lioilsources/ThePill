import Foundation

struct Coaching {
  let isHostile: Bool
  let why: String
  let alternatives: [String]
}

/// POST /coach na pill-core. Fail-open: jakákoli chyba = nil (kouč mlčí).
enum CoachClient {
  static func coach(serverURL: String, text: String, lang: String = "cs", completion: @escaping (Coaching?) -> Void) {
    let base = serverURL.hasSuffix("/") ? String(serverURL.dropLast()) : serverURL
    guard let url = URL(string: base + "/coach") else { return completion(nil) }
    var req = URLRequest(url: url, timeoutInterval: 8)
    req.httpMethod = "POST"
    req.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    req.httpBody = try? JSONSerialization.data(withJSONObject: ["text": text, "lang": lang])
    URLSession.shared.dataTask(with: req) { data, resp, _ in
      guard (resp as? HTTPURLResponse)?.statusCode == 200, let data else { return completion(nil) }
      completion(parse(data))
    }.resume()
  }

  static func parse(_ data: Data) -> Coaching? {
    guard let j = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return nil }
    if j["degraded"] as? Bool == true { return nil }
    let alts = (j["alternatives"] as? [String] ?? [])
      .filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
      .prefix(2)
    let c = Coaching(isHostile: j["is_hostile"] as? Bool ?? false, why: j["why"] as? String ?? "", alternatives: Array(alts))
    return c.isHostile && c.alternatives.isEmpty ? nil : c
  }
}
