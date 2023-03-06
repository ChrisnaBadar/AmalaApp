import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:adhan/adhan.dart';

class HomeController extends GetxController {
  var checkListResult = [].obs;
  var iconCheck = [].obs;
  var activatedCategory = [].obs;
  RxBool saveLoading = false.obs;

  var selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .obs;

  var dailyProgressSelectedValue = {
    'day': DateFormat('EEEE', "id_ID").format(DateTime.now()),
    'date': DateFormat('dd').format(DateTime.now())
  }.obs;
  Rx<bool> isSaved = false.obs;

  var tanggal =
      DateFormat('EEEE, dd MMM yyyy', "id_ID").format(DateTime.now()).obs;
  var lokasi = 'Gegerkalong, Bandung'.obs;
  //Amala kategori control
  static Rx<bool> fardhu = false.obs;
  static Rx<bool> tahajudCat = false.obs;
  static Rx<bool> dhuhaCat = false.obs;
  static Rx<bool> rawatibCat = false.obs;
  static Rx<bool> tilawahCat = false.obs;
  static Rx<bool> shaumCat = false.obs;
  static Rx<bool> sedekahCat = false.obs;
  static Rx<bool> dzikir = false.obs;
  static Rx<bool> taklimCat = false.obs;
  static Rx<bool> isthgfarCat = false.obs;
  static Rx<bool> shalawatCat = false.obs;
  //Amala Core
  static Rx<bool> shubuh = false.obs;
  static Rx<bool> dhuhur = false.obs;
  static Rx<bool> ashar = false.obs;
  static Rx<bool> maghrib = false.obs;
  static Rx<bool> isya = false.obs;
  static Rx<bool> tahajud = false.obs;
  static Rx<bool> dhuha = false.obs;
  static Rx<bool> rawatib = false.obs;
  static Rx<bool> tilawah = false.obs;
  static Rx<bool> shaum = false.obs;
  static Rx<bool> sedekah = false.obs;
  static Rx<bool> dzikirPagi = false.obs;
  static Rx<bool> dzikirPetang = false.obs;
  static Rx<bool> taklim = false.obs;
  static Rx<bool> isthgfar = false.obs;
  static Rx<bool> shalawat = false.obs;

  //prayer times
  var now = DateTime.now();
  PrayerTimes? prayerTimes;
  RxString shalatTitle = ''.obs;
  RxString shalatTimes = ''.obs;
  var levelClock = 0.obs;

  void calculatePrayerTimes(Coordinates coordinate) {
    final params = CalculationMethod.singapore.getParameters();
    params.madhab = Madhab.shafi;
    prayerTimes = PrayerTimes.today(coordinate, params);
    if (!prayerTimes!.fajr.difference(now).isNegative) {
      shalatTitle.value = 'Shalat Shubuh';
      shalatTimes.value = DateFormat.jm().format(prayerTimes!.fajr);
      levelClock.value = prayerTimes!.fajr.difference(now).inSeconds;
    } else if (!prayerTimes!.dhuhr.difference(now).isNegative) {
      shalatTitle.value = 'Shalat Dhuhur';
      shalatTimes.value = DateFormat.jm().format(prayerTimes!.dhuhr);
      levelClock.value = prayerTimes!.dhuhr.difference(now).inSeconds;
    } else if (!prayerTimes!.asr.difference(now).isNegative) {
      shalatTitle.value = 'Shalat Ashar';
      shalatTimes.value = DateFormat.jm().format(prayerTimes!.asr);
      levelClock.value = prayerTimes!.asr.difference(now).inSeconds;
    } else if (!prayerTimes!.maghrib.difference(now).isNegative) {
      shalatTitle.value = 'Shalat Maghrib';
      shalatTimes.value = DateFormat.jm().format(prayerTimes!.maghrib);
      levelClock.value = prayerTimes!.maghrib.difference(now).inSeconds;
    } else if (!prayerTimes!.isha.difference(now).isNegative) {
      shalatTitle.value = 'Shalat Isya';
      shalatTimes.value = DateFormat.jm().format(prayerTimes!.isha);
      levelClock.value = prayerTimes!.isha.difference(now).inSeconds;
    }
  }
}
