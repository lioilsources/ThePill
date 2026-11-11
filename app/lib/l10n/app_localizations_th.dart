// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'The Pill';

  @override
  String get homeIntro =>
      'ก่อนส่ง โค้ชจะเตือนเมื่อข้อความฟังดูเหมือนการโจมตี และเสนอสองเวอร์ชันที่ใจเย็นกว่า โค้ชไม่เคยส่งหรือเขียนทับอะไรเอง';

  @override
  String get setupTitle => 'เปิดใช้งานคีย์บอร์ด';

  @override
  String get setupStepEnable => '1. การตั้งค่า → คีย์บอร์ด → เพิ่ม «The Pill»';

  @override
  String get setupStepFullAccessIos =>
      '2. บน iPhone ให้เปิด «อนุญาตการเข้าถึงทั้งหมด» หากไม่เปิด คีย์บอร์ดจะใช้เครือข่ายไม่ได้และโค้ชจะไม่ทำงาน';

  @override
  String get setupStepSwitch =>
      '3. ขณะพิมพ์ ให้สลับไปใช้ The Pill (ไอคอนลูกโลกหรือคีย์บอร์ด)';

  @override
  String get openSettings => 'เปิดการตั้งค่าคีย์บอร์ด';

  @override
  String get privacyTitle => 'เกิดอะไรขึ้นกับข้อความของคุณ';

  @override
  String get privacyBody =>
      'คีย์บอร์ดส่งข้อความที่คุณกำลังพิมพ์ไปยังเซิร์ฟเวอร์ Pill เพื่อตรวจน้ำเสียงเท่านั้น เซิร์ฟเวอร์ไม่เก็บและไม่บันทึกข้อความนั้น รหัสผ่านและหมายเลขบัตรจะไม่ถูกส่งเลย — ในช่องเหล่านั้นโค้ชจะเงียบ';

  @override
  String get serverTitle => 'เซิร์ฟเวอร์';

  @override
  String get serverUrlLabel => 'ที่อยู่ pill-core';

  @override
  String get tokenLabel => 'โทเค็นการเข้าถึง';

  @override
  String get tokenHint =>
      'สำหรับเซิร์ฟเวอร์สาธารณะเท่านั้น มิฉะนั้นเว้นว่างไว้';

  @override
  String get serverUrlHint => 'http://<IP ของคอมพิวเตอร์>:8090';

  @override
  String get coachEnabled => 'เปิดโค้ช';

  @override
  String get save => 'บันทึก';

  @override
  String get saved => 'บันทึกแล้ว';

  @override
  String get tryTitle => 'ลองใช้โค้ช';

  @override
  String get tryHint => 'พิมพ์ข้อความที่คุณจะส่ง…';

  @override
  String get tryButton => 'ตรวจสอบ';

  @override
  String get tryOk => 'ฟังดูดี';

  @override
  String get tryUnavailable =>
      'ตอนนี้ใช้โค้ชไม่ได้ — ข้อความจะถูกส่งโดยไม่เปลี่ยนแปลง';

  @override
  String get tryAlternatives => 'อีกวิธีหนึ่งในการพูดสิ่งนี้:';
}
