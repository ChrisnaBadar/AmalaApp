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

  Future<void> calculatePrayerTimes(Coordinates coordinate) async {
    final params = CalculationMethod.singapore.getParameters();
    params.madhab = Madhab.shafi;
    prayerTimes = PrayerTimes.today(coordinate, params);
    if (!prayerTimes!.fajr.difference(now).isNegative) {
      CoreData.shalatTitle = 'Shalat Shubuh';
      CoreData.shalatTimes = DateFormat.jm().format(prayerTimes!.fajr);
      CoreData.levelClock = prayerTimes!.fajr.difference(now).inSeconds;
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
      if (CoreData.adhanAlarm) {
        await Alarm.set(alarmSettings: shubuhAlarmSettings);
      }
    } else if (!prayerTimes!.dhuhr.difference(now).isNegative) {
      CoreData.shalatTitle = 'Shalat Dhuhur';
      CoreData.shalatTimes = DateFormat.jm().format(prayerTimes!.dhuhr);
      CoreData.levelClock = prayerTimes!.dhuhr.difference(now).inSeconds;
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
      if (CoreData.adhanAlarm) {
        await Alarm.set(alarmSettings: dhuhurAlarmSettings);
      }
    } else if (!prayerTimes!.asr.difference(now).isNegative) {
      CoreData.shalatTitle = 'Shalat Ashar';
      CoreData.shalatTimes = DateFormat.jm().format(prayerTimes!.asr);
      CoreData.levelClock = prayerTimes!.asr.difference(now).inSeconds;
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
      if (CoreData.adhanAlarm) {
        await Alarm.set(alarmSettings: asharAlarmSettings);
      }
    } else if (!prayerTimes!.maghrib.difference(now).isNegative) {
      CoreData.shalatTitle = 'Shalat Maghrib';
      CoreData.shalatTimes = DateFormat.jm().format(prayerTimes!.maghrib);
      CoreData.levelClock = prayerTimes!.maghrib.difference(now).inSeconds;
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
      if (CoreData.adhanAlarm) {
        await Alarm.set(alarmSettings: maghribAlarmSettings);
      }
    } else if (!prayerTimes!.isha.difference(now).isNegative) {
      CoreData.shalatTitle = 'Shalat Isya';
      CoreData.shalatTimes = DateFormat.jm().format(prayerTimes!.isha);
      CoreData.levelClock = prayerTimes!.isha.difference(now).inSeconds;
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
      if (CoreData.adhanAlarm) {
        await Alarm.set(alarmSettings: isyaAlarmSettings);
      }
    }
  }
}
