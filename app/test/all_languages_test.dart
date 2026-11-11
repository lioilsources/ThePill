import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_pill/l10n/app_localizations.dart';
import 'package:the_pill/main.dart';
import 'package:the_pill/src/shared_config.dart';

/// The 45 interface languages: every one must load, differ from the
/// Czech template where it should, and lay out the home screen without
/// overflow, also right to left (ar, he, ur).
const _expected = [
  'ar',
  'bn',
  'ca',
  'cs',
  'da',
  'de',
  'el',
  'en',
  'es',
  'fi',
  'fr',
  'gu',
  'he',
  'hi',
  'hr',
  'hu',
  'id',
  'it',
  'ja',
  'kn',
  'ko',
  'ml',
  'mr',
  'ms',
  'nb',
  'nl',
  'or',
  'pa',
  'pl',
  'pt',
  'ro',
  'ru',
  'sk',
  'sl',
  'sv',
  'ta',
  'te',
  'th',
  'tr',
  'uk',
  'ur',
  'vi',
  'zh',
];

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const ch = MethodChannel('thepill/shared_config');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(ch, (call) async {
          if (call.method == 'load') {
            return {
              'server_url': 'http://pill.test',
              'coach_enabled': true,
              'token': '',
            };
          }
          return null;
        });
  });

  test('all 45 languages are supported (pt-BR/pt-PT, zh-Hans/zh-Hant)', () {
    final codes = AppLocalizations.supportedLocales
        .map((l) => l.languageCode)
        .toSet();
    expect(codes, containsAll(_expected));
    final tags = AppLocalizations.supportedLocales.map((l) => l.toString());
    expect(tags, containsAll(['pt_PT', 'pt_BR', 'zh_Hant', 'zh_Hans']));
  });

  test('no translation is empty or still the Czech template', () async {
    final cs = await AppLocalizations.delegate.load(const Locale('cs'));
    for (final l in AppLocalizations.supportedLocales) {
      if (l.languageCode == 'cs' || l.languageCode == 'en') continue;
      final t = await AppLocalizations.delegate.load(l);
      expect(t.setupTitle, isNotEmpty, reason: '$l');
      expect(t.setupTitle, isNot(cs.setupTitle), reason: '$l');
      expect(t.tryButton, isNot(cs.tryButton), reason: '$l');
      expect(t.tryHint, isNot(cs.tryHint), reason: '$l');
    }
  });

  for (final l in AppLocalizations.supportedLocales) {
    testWidgets('home screen lays out in $l', (t) async {
      t.view.physicalSize = const Size(800, 1600);
      t.view.devicePixelRatio = 2;
      addTearDown(t.view.reset);
      await t.pumpWidget(
        PillApp(
          store: SharedConfigStore(channel: ch),
          locale: l,
        ),
      );
      await t.pumpAndSettle();
      final ctx = t.element(find.byType(Scaffold).first);
      expect(
        Directionality.of(ctx),
        ['ar', 'he', 'ur'].contains(l.languageCode)
            ? TextDirection.rtl
            : TextDirection.ltr,
      );
      expect(find.text(AppLocalizations.of(ctx).setupTitle), findsWidgets);
      expect(t.takeException(), isNull, reason: '$l');
    });
  }
}
