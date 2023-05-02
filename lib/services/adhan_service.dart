import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';

import '../constants/core_data.dart';

class AdhanService {
  //prayer times
  var now = DateTime.now();
  PrayerTimes? prayerTimes;

  void calculatePrayerTimes(Coordinates coordinate) {
    final params = CalculationMethod.singapore.getParameters();
    params.madhab = Madhab.shafi;
    prayerTimes = PrayerTimes.today(coordinate, params);
    if (!prayerTimes!.fajr.difference(now).isNegative) {
      CoreData.shalatTitle = 'Shalat Shubuh';
      CoreData.shalatTimes = DateFormat.jm().format(prayerTimes!.fajr);
      CoreData.levelClock = prayerTimes!.fajr.difference(now).inSeconds;
    } else if (!prayerTimes!.dhuhr.difference(now).isNegative) {
      CoreData.shalatTitle = 'Shalat Dhuhur';
      CoreData.shalatTimes = DateFormat.jm().format(prayerTimes!.dhuhr);
      CoreData.levelClock = prayerTimes!.dhuhr.difference(now).inSeconds;
    } else if (!prayerTimes!.asr.difference(now).isNegative) {
      CoreData.shalatTitle = 'Shalat Ashar';
      CoreData.shalatTimes = DateFormat.jm().format(prayerTimes!.asr);
      CoreData.levelClock = prayerTimes!.asr.difference(now).inSeconds;
    } else if (!prayerTimes!.maghrib.difference(now).isNegative) {
      CoreData.shalatTitle = 'Shalat Maghrib';
      CoreData.shalatTimes = DateFormat.jm().format(prayerTimes!.maghrib);
      CoreData.levelClock = prayerTimes!.maghrib.difference(now).inSeconds;
    } else if (!prayerTimes!.isha.difference(now).isNegative) {
      CoreData.shalatTitle = 'Shalat Isya';
      CoreData.shalatTimes = DateFormat.jm().format(prayerTimes!.isha);
      CoreData.levelClock = prayerTimes!.isha.difference(now).inSeconds;
    }
  }
}
