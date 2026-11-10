import 'dart:convert';

import 'package:http/http.dart' as http;

/// Výsledek /coach z pill-core.
class Coaching {
  const Coaching({
    required this.isHostile,
    required this.why,
    required this.alternatives,
    this.degraded = false,
  });

  final bool isHostile;
  final String why;
  final List<String> alternatives;

  /// Model byl nedostupný — kouč mlčí, zpráva odejde beze změny.
  final bool degraded;

  factory Coaching.fromJson(Map<String, dynamic> j) => Coaching(
    isHostile: j['is_hostile'] == true,
    why: (j['why'] as String?) ?? '',
    alternatives: ((j['alternatives'] as List?) ?? const [])
        .whereType<String>()
        .where((s) => s.trim().isNotEmpty)
        .take(2)
        .toList(),
    degraded: j['degraded'] == true,
  );

  static const silent = Coaching(
    isHostile: false,
    why: '',
    alternatives: [],
    degraded: true,
  );
}

/// Klient pill-core. Fail-open: jakákoli chyba = kouč mlčí, nikdy neblokuje.
class PillClient {
  PillClient(
    this.baseUrl, {
    this.token = '',
    http.Client? client,
    this.timeout = const Duration(seconds: 8),
  }) : _http = client ?? http.Client();

  final String baseUrl;
  final String token;
  final Duration timeout;
  final http.Client _http;

  Uri _uri(String path) {
    final b = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;
    return Uri.parse('$b$path');
  }

  Future<Coaching> coach(String text, {String lang = 'cs'}) async {
    if (baseUrl.trim().isEmpty || text.trim().isEmpty) return Coaching.silent;
    try {
      final res = await _http
          .post(
            _uri('/coach'),
            headers: {
              'Content-Type': 'application/json; charset=utf-8',
              if (token.isNotEmpty) 'Authorization': 'Bearer $token',
            },
            body: jsonEncode({'text': text, 'lang': lang}),
          )
          .timeout(timeout);
      if (res.statusCode != 200) return Coaching.silent;
      final c = Coaching.fromJson(
        jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>,
      );
      // Útok bez alternativ nemá co nabídnout — mlčet.
      if (c.isHostile && c.alternatives.isEmpty) return Coaching.silent;
      return c;
    } catch (_) {
      return Coaching.silent;
    }
  }
}
