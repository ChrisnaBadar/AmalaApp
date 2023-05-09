import 'package:adhan/adhan.dart';
import 'package:alarm/alarm.dart';
import 'package:intl/intl.dart';
import '../constants/core_data.dart';
import '../constants/my_strings.dart';

class AdhanService {
  //prayer times
  var now = DateTime.now();
  PrayerTimes? prayerTimes;
  DateTime? shubuh;
  DateTime? dhuhur;
  DateTime? ashar;
  DateTime? maghrib;
  DateTime? isya;

  Future<void> calculatePrayerTimes(Coordinates coordinate) async {
    final params = CalculationMethod.singapore.getParameters();
    params.madhab = Madhab.shafi;
    prayerTimes = PrayerTimes.today(coordinate, params);
    if (!prayerTimes!.fajr.difference(now).isNegative) {
      CoreData.shalatTitle = 'Shalat Shubuh';
      CoreData.shalatTimes = DateFormat.jm().format(prayerTimes!.fajr);
      CoreData.levelClock = prayerTimes!.fajr.difference(now).inSeconds;
      shubuh = prayerTimes!.fajr;
    } else if (!prayerTimes!.dhuhr.difference(now).isNegative) {
      CoreData.shalatTitle = 'Shalat Dhuhur';
      CoreData.shalatTimes = DateFormat.jm().format(prayerTimes!.dhuhr);
      CoreData.levelClock = prayerTimes!.dhuhr.difference(now).inSeconds;
      dhuhur = prayerTimes!.dhuhr;
    } else if (!prayerTimes!.asr.difference(now).isNegative) {
      CoreData.shalatTitle = 'Shalat Ashar';
      CoreData.shalatTimes = DateFormat.jm().format(prayerTimes!.asr);
      CoreData.levelClock = prayerTimes!.asr.difference(now).inSeconds;
      ashar = prayerTimes!.asr;
    } else if (!prayerTimes!.maghrib.difference(now).isNegative) {
      CoreData.shalatTitle = 'Shalat Maghrib';
      CoreData.shalatTimes = DateFormat.jm().format(prayerTimes!.maghrib);
      CoreData.levelClock = prayerTimes!.maghrib.difference(now).inSeconds;
      maghrib = prayerTimes!.maghrib;
    } else if (!prayerTimes!.isha.difference(now).isNegative) {
      CoreData.shalatTitle = 'Shalat Isya';
      CoreData.shalatTimes = DateFormat.jm().format(prayerTimes!.isha);
      CoreData.levelClock = prayerTimes!.isha.difference(now).inSeconds;
      isya = prayerTimes!.isha;
    }
  }

  Future<void> setAdhanAlarm(bool activated) async {
    if (shubuh != null) {
      final AlarmSettings shubuhAlarmSettings = AlarmSettings(
        id: 1,
        dateTime: shubuh!,
        assetAudioPath: MyStrings.adhanSound,
        loopAudio: false,
        vibrate: true,
        fadeDuration: 3.0,
        notificationTitle: 'Shalat Shubuh',
        notificationBody: 'Saatnya berangkat ke Masjid',
        enableNotificationOnKill: true,
      );
      activated ? Alarm.set(alarmSettings: shubuhAlarmSettings) : Alarm.stop(1);
    }
    if (dhuhur != null) {
      final AlarmSettings dhuhurAlarmSettings = AlarmSettings(
        id: 2,
        dateTime: dhuhur!,
        assetAudioPath: MyStrings.adhanSound,
        loopAudio: false,
        vibrate: true,
        fadeDuration: 3.0,
        notificationTitle: 'Shalat Dhuhur',
        notificationBody: 'Saatnya berangkat ke Masjid',
        enableNotificationOnKill: true,
      );
      activated ? Alarm.set(alarmSettings: dhuhurAlarmSettings) : Alarm.stop(2);
    }
    if (ashar != null) {
      final AlarmSettings asharAlarmSettings = AlarmSettings(
        id: 3,
        dateTime: ashar!,
        assetAudioPath: MyStrings.adhanSound,
        loopAudio: false,
        vibrate: true,
        fadeDuration: 3.0,
        notificationTitle: 'Shalat Ashar',
        notificationBody: 'Saatnya berangkat ke Masjid',
        enableNotificationOnKill: true,
      );
      activated ? Alarm.set(alarmSettings: asharAlarmSettings) : Alarm.stop(3);
    }
    if (maghrib != null) {
      final AlarmSettings maghribAlarmSettings = AlarmSettings(
        id: 4,
        dateTime: maghrib!,
        assetAudioPath: MyStrings.adhanSound,
        loopAudio: false,
        vibrate: true,
        fadeDuration: 3.0,
        notificationTitle: 'Shalat Maghrib',
        notificationBody: 'Saatnya berangkat ke Masjid',
        enableNotificationOnKill: true,
      );
      activated
          ? Alarm.set(alarmSettings: maghribAlarmSettings)
          : Alarm.stop(4);
    }
    if (isya != null) {
      final AlarmSettings isyaAlarmSettings = AlarmSettings(
        id: 5,
        dateTime: prayerTimes!.isha,
        assetAudioPath: MyStrings.adhanSound,
        loopAudio: false,
        vibrate: true,
        fadeDuration: 3.0,
        notificationTitle: 'Shalat Isya',
        notificationBody: 'Saatnya berangkat ke Masjid',
        enableNotificationOnKill: true,
      );
      activated ? Alarm.set(alarmSettings: isyaAlarmSettings) : Alarm.stop(5);
    }
  }
}
