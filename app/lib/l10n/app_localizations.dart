import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_cs.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('cs'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In cs, this message translates to:
  /// **'The Pill'**
  String get appTitle;

  /// No description provided for @homeIntro.
  ///
  /// In cs, this message translates to:
  /// **'Kouč tě před odesláním upozorní, když zpráva zní jako útok, a nabídne dvě klidnější verze. Nic neodešle ani nepřepíše sám.'**
  String get homeIntro;

  /// No description provided for @setupTitle.
  ///
  /// In cs, this message translates to:
  /// **'Zapnutí klávesnice'**
  String get setupTitle;

  /// No description provided for @setupStepEnable.
  ///
  /// In cs, this message translates to:
  /// **'1. Nastavení → Klávesnice → přidej „The Pill“.'**
  String get setupStepEnable;

  /// No description provided for @setupStepFullAccessIos.
  ///
  /// In cs, this message translates to:
  /// **'2. Na iPhonu zapni „Povolit plný přístup“. Bez něj klávesnice nesmí na síť a kouč nefunguje.'**
  String get setupStepFullAccessIos;

  /// No description provided for @setupStepSwitch.
  ///
  /// In cs, this message translates to:
  /// **'3. Při psaní přepni na The Pill (ikona glóbu nebo klávesnice).'**
  String get setupStepSwitch;

  /// No description provided for @openSettings.
  ///
  /// In cs, this message translates to:
  /// **'Otevřít nastavení klávesnice'**
  String get openSettings;

  /// No description provided for @privacyTitle.
  ///
  /// In cs, this message translates to:
  /// **'Co se děje s textem'**
  String get privacyTitle;

  /// No description provided for @privacyBody.
  ///
  /// In cs, this message translates to:
  /// **'Klávesnice pošle text rozepsané zprávy na server Pilulky jen ke kontrole tónu. Server text neukládá ani neloguje. Hesla a čísla karet klávesnice nikdy neposílá — v těch polích kouč mlčí.'**
  String get privacyBody;

  /// No description provided for @serverTitle.
  ///
  /// In cs, this message translates to:
  /// **'Server'**
  String get serverTitle;

  /// No description provided for @serverUrlLabel.
  ///
  /// In cs, this message translates to:
  /// **'Adresa pill-core'**
  String get serverUrlLabel;

  /// No description provided for @tokenLabel.
  ///
  /// In cs, this message translates to:
  /// **'Přístupový token'**
  String get tokenLabel;

  /// No description provided for @tokenHint.
  ///
  /// In cs, this message translates to:
  /// **'jen pro veřejný server, jinak nech prázdné'**
  String get tokenHint;

  /// No description provided for @serverUrlHint.
  ///
  /// In cs, this message translates to:
  /// **'http://<IP počítače>:8090'**
  String get serverUrlHint;

  /// No description provided for @coachEnabled.
  ///
  /// In cs, this message translates to:
  /// **'Kouč zapnutý'**
  String get coachEnabled;

  /// No description provided for @save.
  ///
  /// In cs, this message translates to:
  /// **'Uložit'**
  String get save;

  /// No description provided for @saved.
  ///
  /// In cs, this message translates to:
  /// **'Uloženo'**
  String get saved;

  /// No description provided for @tryTitle.
  ///
  /// In cs, this message translates to:
  /// **'Vyzkoušej kouče'**
  String get tryTitle;

  /// No description provided for @tryHint.
  ///
  /// In cs, this message translates to:
  /// **'Napiš zprávu, kterou bys poslal(a)…'**
  String get tryHint;

  /// No description provided for @tryButton.
  ///
  /// In cs, this message translates to:
  /// **'Zkontrolovat'**
  String get tryButton;

  /// No description provided for @tryOk.
  ///
  /// In cs, this message translates to:
  /// **'Zní to v pohodě.'**
  String get tryOk;

  /// No description provided for @tryUnavailable.
  ///
  /// In cs, this message translates to:
  /// **'Kouč je teď nedostupný — zpráva by odešla beze změny.'**
  String get tryUnavailable;

  /// No description provided for @tryAlternatives.
  ///
  /// In cs, this message translates to:
  /// **'Jak to říct jinak:'**
  String get tryAlternatives;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['cs', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'cs':
      return AppLocalizationsCs();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
