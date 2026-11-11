// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'भेजने से पहले कोच बताता है कि संदेश हमले जैसा लग रहा है और दो शांत रूप सुझाता है। वह अपने आप कुछ भेजता या बदलता नहीं है।';

  @override
  String get setupTitle => 'कीबोर्ड चालू करना';

  @override
  String get setupStepEnable => '1. सेटिंग्स → कीबोर्ड → «The Pill» जोड़ें।';

  @override
  String get setupStepFullAccessIos =>
      '2. iPhone पर «पूर्ण एक्सेस की अनुमति दें» चालू करें। इसके बिना कीबोर्ड नेटवर्क इस्तेमाल नहीं कर सकता और कोच काम नहीं करता।';

  @override
  String get setupStepSwitch =>
      '3. टाइप करते समय The Pill पर स्विच करें (ग्लोब या कीबोर्ड आइकन)।';

  @override
  String get openSettings => 'कीबोर्ड सेटिंग्स खोलें';

  @override
  String get privacyTitle => 'आपके टेक्स्ट का क्या होता है';

  @override
  String get privacyBody =>
      'कीबोर्ड सिर्फ़ लहजा जाँचने के लिए आपके लिखे संदेश का टेक्स्ट Pill सर्वर को भेजता है। सर्वर उसे न सहेजता है, न लॉग करता है। पासवर्ड और कार्ड नंबर कभी नहीं भेजे जाते — उन खानों में कोच चुप रहता है।';

  @override
  String get serverTitle => 'सर्वर';

  @override
  String get serverUrlLabel => 'pill-core का पता';

  @override
  String get tokenLabel => 'एक्सेस टोकन';

  @override
  String get tokenHint => 'सिर्फ़ सार्वजनिक सर्वर के लिए, वरना खाली छोड़ें';

  @override
  String get serverUrlHint => 'http://<कंप्यूटर का IP>:8090';

  @override
  String get coachEnabled => 'कोच चालू';

  @override
  String get save => 'सहेजें';

  @override
  String get saved => 'सहेजा गया';

  @override
  String get tryTitle => 'कोच आज़माएँ';

  @override
  String get tryHint => 'वह संदेश लिखें जो आप भेजेंगे…';

  @override
  String get tryButton => 'जाँचें';

  @override
  String get tryOk => 'ठीक लग रहा है।';

  @override
  String get tryUnavailable =>
      'कोच अभी उपलब्ध नहीं है — संदेश बिना बदले चला जाएगा।';

  @override
  String get tryAlternatives => 'इसे दूसरे तरीके से कहें:';
}
