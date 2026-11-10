import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:the_pill/src/pill_client.dart';

http.Response jsonRes(Object body, [int status = 200]) => http.Response.bytes(
  utf8.encode(jsonEncode(body)),
  status,
  headers: {'content-type': 'application/json; charset=utf-8'},
);

void main() {
  test('vrací alternativy u útoku a posílá text na /coach', () async {
    late http.Request seen;
    final c = PillClient(
      'http://pill.test/',
      client: MockClient((req) async {
        seen = req;
        return jsonRes({
          'is_hostile': true,
          'why': 'Zní to jako útok.',
          'alternatives': [
            'Prosím, kde jsou klíče?',
            'Nemůžu najít klíče, nevíš?',
            'třetí navíc',
          ],
        });
      }),
    );
    final r = await c.coach('KDE SAKRA JSOU KLÍČE');
    expect(seen.url.toString(), 'http://pill.test/coach');
    expect(jsonDecode(seen.body)['text'], 'KDE SAKRA JSOU KLÍČE');
    expect(r.isHostile, isTrue);
    expect(r.alternatives, hasLength(2));
    expect(r.degraded, isFalse);
  });

  test(
    'fail-open: chyba serveru, výjimka i prázdná adresa = kouč mlčí',
    () async {
      for (final mock in [
        MockClient((_) async => jsonRes({}, 500)),
        MockClient((_) async => throw Exception('offline')),
        MockClient((_) async => http.Response('nejson', 200)),
      ]) {
        final r = await PillClient(
          'http://pill.test',
          client: mock,
        ).coach('ahoj');
        expect(r.isHostile, isFalse);
        expect(r.degraded, isTrue);
      }
      expect((await PillClient('').coach('ahoj')).degraded, isTrue);
    },
  );

  test('útok bez alternativ se nezobrazí', () async {
    final c = PillClient(
      'http://pill.test',
      client: MockClient(
        (_) async =>
            jsonRes({'is_hostile': true, 'why': 'x', 'alternatives': []}),
      ),
    );
    expect((await c.coach('x')).isHostile, isFalse);
  });

  test('token jde v hlavičce Authorization, bez tokenu se neposílá', () async {
    final seen = <String?>[];
    final mock = MockClient((req) async {
      seen.add(req.headers['Authorization']);
      return jsonRes({'is_hostile': false, 'why': '', 'alternatives': []});
    });
    await PillClient(
      'http://pill.test',
      token: 's3cret',
      client: mock,
    ).coach('x');
    await PillClient('http://pill.test', client: mock).coach('x');
    expect(seen, ['Bearer s3cret', null]);
  });
}
