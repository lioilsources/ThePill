// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Sebelum menghantar, jurulatih memberi amaran apabila mesej kedengaran seperti serangan dan mencadangkan dua versi yang lebih tenang. Ia tidak pernah menghantar atau menulis semula apa-apa sendiri.';

  @override
  String get setupTitle => 'Mengaktifkan papan kekunci';

  @override
  String get setupStepEnable =>
      '1. Tetapan → Papan Kekunci → tambah «The Pill».';

  @override
  String get setupStepFullAccessIos =>
      '2. Pada iPhone, hidupkan «Benarkan Akses Penuh». Tanpanya papan kekunci tidak boleh menggunakan rangkaian dan jurulatih tidak berfungsi.';

  @override
  String get setupStepSwitch =>
      '3. Semasa menaip, tukar ke The Pill (ikon glob atau papan kekunci).';

  @override
  String get openSettings => 'Buka tetapan papan kekunci';

  @override
  String get privacyTitle => 'Apa yang berlaku pada teks anda';

  @override
  String get privacyBody =>
      'Papan kekunci menghantar teks mesej yang anda taip ke pelayan Pill hanya untuk menyemak nada. Pelayan tidak menyimpan atau merekodkannya. Kata laluan dan nombor kad tidak pernah dihantar — dalam medan itu jurulatih diam.';

  @override
  String get serverTitle => 'Pelayan';

  @override
  String get serverUrlLabel => 'Alamat pill-core';

  @override
  String get tokenLabel => 'Token akses';

  @override
  String get tokenHint => 'hanya untuk pelayan awam, jika tidak biarkan kosong';

  @override
  String get serverUrlHint => 'http://<IP komputer>:8090';

  @override
  String get coachEnabled => 'Jurulatih dihidupkan';

  @override
  String get save => 'Simpan';

  @override
  String get saved => 'Disimpan';

  @override
  String get tryTitle => 'Cuba jurulatih';

  @override
  String get tryHint => 'Taip mesej yang akan anda hantar…';

  @override
  String get tryButton => 'Semak';

  @override
  String get tryOk => 'Kedengaran baik.';

  @override
  String get tryUnavailable =>
      'Jurulatih tidak tersedia sekarang — mesej akan dihantar tanpa perubahan.';

  @override
  String get tryAlternatives => 'Cara lain untuk menyatakannya:';
}
