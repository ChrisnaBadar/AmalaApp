import 'package:adhan/adhan.dart';
import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
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
    final AlarmSettings dhuhurAlarmSettings = AlarmSettings(
      id: 2,
      dateTime: prayerTimes!.dhuhr,
      assetAudioPath: MyStrings.adhanSound,
      loopAudio: false,
      vibrate: true,
      fadeDuration: 3.0,
      notificationTitle: 'Shalat Dhuhur',
      notificationBody: 'Saatnya berangkat ke Masjid',
      enableNotificationOnKill: true,
    );
    final AlarmSettings shubuhAlarmSettings = AlarmSettings(
      id: 1,
      dateTime: prayerTimes!.fajr,
      assetAudioPath: MyStrings.adhanSound,
      loopAudio: false,
      vibrate: true,
      fadeDuration: 3.0,
      notificationTitle: 'Shalat Shubuh',
      notificationBody: 'Saatnya berangkat ke Masjid',
      enableNotificationOnKill: true,
    );
    final AlarmSettings asharAlarmSettings = AlarmSettings(
      id: 3,
      dateTime: prayerTimes!.asr,
      assetAudioPath: MyStrings.adhanSound,
      loopAudio: false,
      vibrate: true,
      fadeDuration: 3.0,
      notificationTitle: 'Shalat Ashar',
      notificationBody: 'Saatnya berangkat ke Masjid',
      enableNotificationOnKill: true,
    );
    final AlarmSettings maghribAlarmSettings = AlarmSettings(
      id: 4,
      dateTime: prayerTimes!.maghrib,
      assetAudioPath: MyStrings.adhanSound,
      loopAudio: false,
      vibrate: true,
      fadeDuration: 3.0,
      notificationTitle: 'Shalat Maghrib',
      notificationBody: 'Saatnya berangkat ke Masjid',
      enableNotificationOnKill: true,
    );
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
    if (activated) {
      await Alarm.set(alarmSettings: shubuhAlarmSettings);
      await Alarm.set(alarmSettings: dhuhurAlarmSettings);
      await Alarm.set(alarmSettings: asharAlarmSettings);
      await Alarm.set(alarmSettings: maghribAlarmSettings);
      await Alarm.set(alarmSettings: isyaAlarmSettings);
    } else {
      await Alarm.stop(1);
      await Alarm.stop(2);
      await Alarm.stop(3);
      await Alarm.stop(4);
      await Alarm.stop(5);
    }
  }
}
