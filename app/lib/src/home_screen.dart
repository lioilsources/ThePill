import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import 'pill_client.dart';
import 'shared_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.store,
    required this.clientFactory,
  });

  final SharedConfigStore store;
  final PillClient Function(String baseUrl, String token) clientFactory;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _url = TextEditingController();
  final _token = TextEditingController();
  final _try = TextEditingController();
  bool _coachEnabled = true;
  bool _checking = false;
  Coaching? _result;

  @override
  void initState() {
    super.initState();
    widget.store.load().then((c) {
      if (!mounted) return;
      setState(() {
        _url.text = c.serverUrl;
        _token.text = c.token;
        _coachEnabled = c.coachEnabled;
      });
    });
  }

  @override
  void dispose() {
    _url.dispose();
    _token.dispose();
    _try.dispose();
    super.dispose();
  }

  bool get _isIos => !kIsWeb && Platform.isIOS;

  Future<void> _save() async {
    final l = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    await widget.store.save(
      PillConfig(
        serverUrl: _url.text,
        coachEnabled: _coachEnabled,
        token: _token.text,
      ),
    );
    messenger.showSnackBar(SnackBar(content: Text(l.saved)));
  }

  Future<void> _check() async {
    setState(() {
      _checking = true;
      _result = null;
    });
    final r = await widget
        .clientFactory(_url.text.trim(), _token.text.trim())
        .coach(_try.text);
    if (!mounted) return;
    setState(() {
      _checking = false;
      _result = r;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(l.appTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(l.homeIntro, style: t.bodyLarge),
            const SizedBox(height: 24),
            Text(l.setupTitle, style: t.titleMedium),
            const SizedBox(height: 8),
            Text(l.setupStepEnable),
            if (_isIos) ...[
              const SizedBox(height: 4),
              Text(l.setupStepFullAccessIos),
            ],
            const SizedBox(height: 4),
            Text(l.setupStepSwitch),
            const SizedBox(height: 8),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: OutlinedButton(
                onPressed: widget.store.openKeyboardSettings,
                child: Text(l.openSettings),
              ),
            ),
            const SizedBox(height: 24),
            Text(l.privacyTitle, style: t.titleMedium),
            const SizedBox(height: 8),
            Text(l.privacyBody),
            const SizedBox(height: 24),
            Text(l.serverTitle, style: t.titleMedium),
            TextField(
              key: const Key('serverUrl'),
              controller: _url,
              keyboardType: TextInputType.url,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: l.serverUrlLabel,
                hintText: l.serverUrlHint,
              ),
            ),
            TextField(
              key: const Key('token'),
              controller: _token,
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                labelText: l.tokenLabel,
                hintText: l.tokenHint,
              ),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l.coachEnabled),
              value: _coachEnabled,
              onChanged: (v) => setState(() => _coachEnabled = v),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: FilledButton(
                key: const Key('saveButton'),
                onPressed: _save,
                child: Text(l.save),
              ),
            ),
            const SizedBox(height: 24),
            Text(l.tryTitle, style: t.titleMedium),
            TextField(
              key: const Key('tryText'),
              controller: _try,
              minLines: 2,
              maxLines: 5,
              decoration: InputDecoration(hintText: l.tryHint),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: FilledButton.tonal(
                key: const Key('tryButton'),
                onPressed: _checking ? null : _check,
                child: Text(l.tryButton),
              ),
            ),
            if (_checking)
              const Padding(
                padding: EdgeInsets.all(16),
                child: LinearProgressIndicator(),
              ),
            if (_result != null) _ResultCard(result: _result!),
          ],
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result});

  final Coaching result;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final String headline;
    if (result.degraded) {
      headline = l.tryUnavailable;
    } else if (!result.isHostile) {
      headline = l.tryOk;
    } else {
      headline = result.why;
    }
    return Card(
      margin: const EdgeInsets.only(top: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(headline, key: const Key('tryHeadline')),
            if (result.isHostile && result.alternatives.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                l.tryAlternatives,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              for (final a in result.alternatives)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: SelectableText('• $a'),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
