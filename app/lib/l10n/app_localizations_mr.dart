// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'पाठवण्यापूर्वी संदेश हल्ल्यासारखा वाटला तर कोच सावध करतो आणि दोन शांत रूपे सुचवतो. तो स्वतःहून काही पाठवत किंवा बदलत नाही.';

  @override
  String get setupTitle => 'कीबोर्ड सुरू करणे';

  @override
  String get setupStepEnable => '1. सेटिंग्ज → कीबोर्ड → «The Pill» जोडा.';

  @override
  String get setupStepFullAccessIos =>
      '2. iPhone वर «पूर्ण प्रवेशाला परवानगी द्या» सुरू करा. त्याशिवाय कीबोर्डला नेटवर्क वापरता येत नाही आणि कोच काम करत नाही.';

  @override
  String get setupStepSwitch =>
      '3. टाइप करताना The Pill वर स्विच करा (ग्लोब किंवा कीबोर्ड आयकॉन).';

  @override
  String get openSettings => 'कीबोर्ड सेटिंग्ज उघडा';

  @override
  String get privacyTitle => 'तुमच्या मजकुराचे काय होते';

  @override
  String get privacyBody =>
      'कीबोर्ड फक्त सूर तपासण्यासाठी तुम्ही लिहीत असलेल्या संदेशाचा मजकूर Pill सर्व्हरला पाठवतो. सर्व्हर तो साठवत नाही आणि लॉग करत नाही. पासवर्ड आणि कार्ड क्रमांक कधीही पाठवले जात नाहीत — त्या रकान्यांत कोच गप्प राहतो.';

  @override
  String get serverTitle => 'सर्व्हर';

  @override
  String get serverUrlLabel => 'pill-core चा पत्ता';

  @override
  String get tokenLabel => 'प्रवेश टोकन';

  @override
  String get tokenHint => 'फक्त सार्वजनिक सर्व्हरसाठी, अन्यथा रिकामे ठेवा';

  @override
  String get serverUrlHint => 'http://<संगणकाचा IP>:8090';

  @override
  String get coachEnabled => 'कोच सुरू';

  @override
  String get save => 'जतन करा';

  @override
  String get saved => 'जतन केले';

  @override
  String get tryTitle => 'कोच वापरून पहा';

  @override
  String get tryHint => 'तुम्ही पाठवाल असा संदेश लिहा…';

  @override
  String get tryButton => 'तपासा';

  @override
  String get tryOk => 'ठीक वाटते.';

  @override
  String get tryUnavailable => 'कोच आत्ता उपलब्ध नाही — संदेश बदल न करता जाईल.';

  @override
  String get tryAlternatives => 'हे दुसऱ्या प्रकारे सांगायला:';
}
