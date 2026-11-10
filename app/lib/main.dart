import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/app_localizations.dart';
import 'src/home_screen.dart';
import 'src/pill_client.dart';
import 'src/shared_config.dart';

void main() {
  runApp(PillApp(store: SharedConfigStore()));
}

class PillApp extends StatelessWidget {
  const PillApp({
    super.key,
    required this.store,
    this.clientFactory,
    this.locale,
  });

  /// Pevná lokalizace (testy); jinak podle systému.
  final Locale? locale;

  final SharedConfigStore store;

  /// Pro testy: podstrčit klienta bez sítě.
  final PillClient Function(String baseUrl, String token)? clientFactory;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (c) => AppLocalizations.of(c).appTitle,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF6B8F71),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: const Color(0xFF6B8F71),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale,
      home: HomeScreen(
        store: store,
        clientFactory:
            clientFactory ?? (url, token) => PillClient(url, token: token),
      ),
    );
  }
}
