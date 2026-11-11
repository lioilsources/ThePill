// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Πριν στείλεις, ο προπονητής σε προειδοποιεί όταν ένα μήνυμα ακούγεται σαν επίθεση και προτείνει δύο πιο ήρεμες εκδοχές. Δεν στέλνει ούτε ξαναγράφει τίποτα μόνος του.';

  @override
  String get setupTitle => 'Ενεργοποίηση του πληκτρολογίου';

  @override
  String get setupStepEnable =>
      '1. Ρυθμίσεις → Πληκτρολόγια → πρόσθεσε το «The Pill».';

  @override
  String get setupStepFullAccessIos =>
      '2. Στο iPhone ενεργοποίησε το «Να επιτρέπεται πλήρης πρόσβαση». Χωρίς αυτό το πληκτρολόγιο δεν έχει δίκτυο και ο προπονητής δεν δουλεύει.';

  @override
  String get setupStepSwitch =>
      '3. Την ώρα που γράφεις, πέρασε στο The Pill (εικονίδιο υδρογείου ή πληκτρολογίου).';

  @override
  String get openSettings => 'Άνοιγμα ρυθμίσεων πληκτρολογίου';

  @override
  String get privacyTitle => 'Τι γίνεται με το κείμενό σου';

  @override
  String get privacyBody =>
      'Το πληκτρολόγιο στέλνει το κείμενο του μηνύματος που γράφεις στον διακομιστή Pill μόνο για έλεγχο του τόνου. Ο διακομιστής δεν το αποθηκεύει ούτε το καταγράφει. Κωδικοί και αριθμοί καρτών δεν στέλνονται ποτέ — σε αυτά τα πεδία ο προπονητής σιωπά.';

  @override
  String get serverTitle => 'Διακομιστής';

  @override
  String get serverUrlLabel => 'Διεύθυνση pill-core';

  @override
  String get tokenLabel => 'Διακριτικό πρόσβασης';

  @override
  String get tokenHint => 'μόνο για δημόσιο διακομιστή, αλλιώς άφησέ το κενό';

  @override
  String get serverUrlHint => 'http://<IP του υπολογιστή>:8090';

  @override
  String get coachEnabled => 'Προπονητής ενεργός';

  @override
  String get save => 'Αποθήκευση';

  @override
  String get saved => 'Αποθηκεύτηκε';

  @override
  String get tryTitle => 'Δοκίμασε τον προπονητή';

  @override
  String get tryHint => 'Γράψε ένα μήνυμα που θα έστελνες…';

  @override
  String get tryButton => 'Έλεγχος';

  @override
  String get tryOk => 'Ακούγεται εντάξει.';

  @override
  String get tryUnavailable =>
      'Ο προπονητής δεν είναι διαθέσιμος τώρα — το μήνυμα θα έφευγε αναλλοίωτο.';

  @override
  String get tryAlternatives => 'Άλλος τρόπος να το πεις:';
}
