import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:the_pill/main.dart';
import 'package:the_pill/src/pill_client.dart';
import 'package:the_pill/src/shared_config.dart';

final listScroll = find.byType(Scrollable).first;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const ch = MethodChannel('thepill/shared_config');
  final saved = <Object?>[];

  setUp(() {
    saved.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(ch, (call) async {
          switch (call.method) {
            case 'load':
              return {'server_url': 'http://pill.test', 'coach_enabled': true};
            case 'save':
              saved.add(call.arguments);
              return null;
          }
          return null;
        });
  });

  Future<void> pumpApp(WidgetTester t, MockClient mock) async {
    await t.pumpWidget(
      PillApp(
        store: SharedConfigStore(channel: ch),
        clientFactory: (url) => PillClient(url, client: mock),
        locale: const Locale('cs'),
      ),
    );
    await t.pumpAndSettle();
  }

  testWidgets('načte adresu a uloží nastavení přes kanál', (t) async {
    await pumpApp(t, MockClient((_) async => http.Response('{}', 200)));
    expect(find.text('http://pill.test'), findsOneWidget);
    await t.scrollUntilVisible(
      find.byKey(const Key('saveButton')),
      200,
      scrollable: listScroll,
    );
    await t.tap(find.byKey(const Key('saveButton')));
    await t.pumpAndSettle();
    expect(saved.single, {
      'server_url': 'http://pill.test',
      'coach_enabled': true,
    });
  });

  testWidgets('vyzkoušení kouče ukáže důvod a alternativy', (t) async {
    await pumpApp(
      t,
      MockClient(
        (_) async => http.Response.bytes(
          utf8.encode(
            '{"is_hostile":true,"why":"Zní to jako útok.","alternatives":["Verze A","Verze B"]}',
          ),
          200,
        ),
      ),
    );
    await t.scrollUntilVisible(
      find.byKey(const Key('tryButton')),
      200,
      scrollable: listScroll,
    );
    await t.enterText(find.byKey(const Key('tryText')), 'KDE SAKRA JSOU KLÍČE');
    await t.ensureVisible(find.byKey(const Key('tryButton')));
    await t.tap(find.byKey(const Key('tryButton')));
    await t.pumpAndSettle();
    await t.scrollUntilVisible(
      find.byKey(const Key('tryHeadline')),
      200,
      scrollable: listScroll,
    );
    expect(find.text('Zní to jako útok.'), findsOneWidget);
    expect(find.text('• Verze A'), findsOneWidget);
  });

  testWidgets('nedostupný kouč řekne, že zpráva odejde beze změny', (t) async {
    await pumpApp(t, MockClient((_) async => throw Exception('offline')));
    await t.scrollUntilVisible(
      find.byKey(const Key('tryButton')),
      200,
      scrollable: listScroll,
    );
    await t.enterText(find.byKey(const Key('tryText')), 'ahoj');
    await t.ensureVisible(find.byKey(const Key('tryButton')));
    await t.tap(find.byKey(const Key('tryButton')));
    await t.pumpAndSettle();
    await t.scrollUntilVisible(
      find.byKey(const Key('tryHeadline')),
      200,
      scrollable: listScroll,
    );
    expect(find.textContaining('nedostupný'), findsOneWidget);
  });
}
