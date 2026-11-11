// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'পাঠানোর আগে কোচ জানায় যখন বার্তাটি আক্রমণের মতো শোনায় এবং দুটি শান্ত রূপ দেয়। নিজে থেকে কিছু পাঠায় না বা বদলায় না।';

  @override
  String get setupTitle => 'কিবোর্ড চালু করা';

  @override
  String get setupStepEnable => '১. সেটিংস → কিবোর্ড → «The Pill» যোগ করো।';

  @override
  String get setupStepFullAccessIos =>
      '২. আইফোনে «পূর্ণ অ্যাক্সেস অনুমতি দিন» চালু করো। এটা ছাড়া কিবোর্ড নেটওয়ার্কে যেতে পারে না, কোচও কাজ করে না।';

  @override
  String get setupStepSwitch =>
      '৩. টাইপ করার সময় The Pill-এ বদলাও (গ্লোব বা কিবোর্ড আইকন)।';

  @override
  String get openSettings => 'কিবোর্ড সেটিংস খোলো';

  @override
  String get privacyTitle => 'তোমার লেখার কী হয়';

  @override
  String get privacyBody =>
      'কিবোর্ড শুধু সুর যাচাই করতে লেখা বার্তার টেক্সট Pill সার্ভারে পাঠায়। সার্ভার টেক্সট জমা রাখে না বা লগ করে না। পাসওয়ার্ড ও কার্ড নম্বর কখনও পাঠানো হয় না — ওই ঘরগুলোতে কোচ চুপ থাকে।';

  @override
  String get serverTitle => 'সার্ভার';

  @override
  String get serverUrlLabel => 'pill-core ঠিকানা';

  @override
  String get tokenLabel => 'অ্যাক্সেস টোকেন';

  @override
  String get tokenHint => 'শুধু পাবলিক সার্ভারের জন্য, নইলে ফাঁকা রাখো';

  @override
  String get serverUrlHint => 'http://<কম্পিউটারের IP>:8090';

  @override
  String get coachEnabled => 'কোচ চালু';

  @override
  String get save => 'সংরক্ষণ';

  @override
  String get saved => 'সংরক্ষিত';

  @override
  String get tryTitle => 'কোচ পরীক্ষা করো';

  @override
  String get tryHint => 'যে বার্তা পাঠাতে চাও সেটা লেখো…';

  @override
  String get tryButton => 'যাচাই করো';

  @override
  String get tryOk => 'ঠিকই শোনাচ্ছে।';

  @override
  String get tryUnavailable =>
      'কোচ এখন পাওয়া যাচ্ছে না — বার্তা অপরিবর্তিত যাবে।';

  @override
  String get tryAlternatives => 'অন্যভাবে বলার উপায়:';
}
