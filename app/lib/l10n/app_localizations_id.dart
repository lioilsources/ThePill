// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'Sebelum mengirim, pelatih memperingatkan jika pesan terdengar seperti serangan dan menawarkan dua versi yang lebih tenang. Ia tidak pernah mengirim atau menulis ulang apa pun sendiri.';

  @override
  String get setupTitle => 'Mengaktifkan papan ketik';

  @override
  String get setupStepEnable =>
      '1. Pengaturan → Papan ketik → tambahkan «The Pill».';

  @override
  String get setupStepFullAccessIos =>
      '2. Di iPhone, aktifkan «Izinkan Akses Penuh». Tanpa itu papan ketik tidak bisa memakai jaringan dan pelatih tidak berfungsi.';

  @override
  String get setupStepSwitch =>
      '3. Saat mengetik, beralihlah ke The Pill (ikon bola dunia atau papan ketik).';

  @override
  String get openSettings => 'Buka pengaturan papan ketik';

  @override
  String get privacyTitle => 'Apa yang terjadi pada teksmu';

  @override
  String get privacyBody =>
      'Papan ketik mengirim teks pesan yang kamu ketik ke server Pill hanya untuk memeriksa nada. Server tidak menyimpan atau mencatatnya. Kata sandi dan nomor kartu tidak pernah dikirim — di kolom itu pelatih diam.';

  @override
  String get serverTitle => 'Server';

  @override
  String get serverUrlLabel => 'Alamat pill-core';

  @override
  String get tokenLabel => 'Token akses';

  @override
  String get tokenHint => 'hanya untuk server publik, selain itu kosongkan';

  @override
  String get serverUrlHint => 'http://<IP komputer>:8090';

  @override
  String get coachEnabled => 'Pelatih aktif';

  @override
  String get save => 'Simpan';

  @override
  String get saved => 'Tersimpan';

  @override
  String get tryTitle => 'Coba pelatihnya';

  @override
  String get tryHint => 'Ketik pesan yang akan kamu kirim…';

  @override
  String get tryButton => 'Periksa';

  @override
  String get tryOk => 'Kedengarannya baik.';

  @override
  String get tryUnavailable =>
      'Pelatih tidak tersedia sekarang — pesan akan terkirim tanpa perubahan.';

  @override
  String get tryAlternatives => 'Cara lain mengatakannya:';
}
