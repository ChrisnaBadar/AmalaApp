import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/hive/hive_yaumi_model.dart';

class YaumiLogController extends GetxController {
  //TOTAL Active Category
  RxDouble myTotalPoints = 0.0.obs;

  void calculateMyTotalPoints(List categoryList, List pointsList) {
    var activeCategory = categoryList.where((e) => e == true).length;
    myTotalPoints.value =
        ((pointsList.fold(0.0, (p, e) => p + e)) / activeCategory) * 100;
    print('activeCategory: $activeCategory');
  }

  //TOTAL
  double dailyYaumiProgressPoin(
      bool fardhu,
      bool shubuh,
      bool dhuhur,
      bool ashar,
      bool maghrib,
      bool isya,
      bool activeTahajud,
      bool tahajud,
      bool activeDhuha,
      bool dhuha,
      bool activeRawatib,
      bool rawatib,
      bool activeTilawah,
      bool tilawah,
      bool activeShaum,
      bool shaum,
      bool activeSedekah,
      bool sedekah,
      bool activeDzikir,
      bool dzikirPagi,
      bool dzikirPetang,
      bool activeTaklim,
      bool taklim,
      bool activeIstighfar,
      bool istighfar,
      bool activeShalawat,
      bool shalawat) {
    var shubuhPoin = shubuh ? 1 : 0;
    var dhuhurPoin = dhuhur ? 1 : 0;
    var asharPoin = ashar ? 1 : 0;
    var maghribPoin = maghrib ? 1 : 0;
    var isyaPoin = isya ? 1 : 0;

    var fardhuPoin = fardhu
        ? (shubuhPoin + dhuhurPoin + asharPoin + maghribPoin + isyaPoin)
        : 5;
    var tahajudPoin = activeTahajud ? (tahajud ? 1 : 0) : 1;
    var dhuhaPoin = activeDhuha ? (dhuha ? 1 : 0) : 1;
    var rawatibPoin = activeRawatib ? (rawatib ? 1 : 0) : 1;
    var tilawahPoin = activeTilawah ? (tilawah ? 1 : 0) : 1;
    var shaumPoin = activeShaum ? (shaum ? 1 : 0) : 1;
    var sedekahPoin = activeSedekah ? (sedekah ? 1 : 0) : 1;
    var dzikirPoin =
        activeDzikir ? ((dzikirPagi ? 1 : 0) + (dzikirPetang ? 1 : 0)) : 2;
    var taklimPoin = activeTaklim ? (taklim ? 1 : 0) : 1;
    var istighfarPoin = activeIstighfar ? (istighfar ? 1 : 0) : 1;
    var shalawatPoin = activeShalawat ? (shalawat ? 1 : 0) : 1;

    var finalPoin = ((fardhuPoin +
                tahajudPoin +
                dhuhaPoin +
                rawatibPoin +
                tilawahPoin +
                shaumPoin +
                sedekahPoin +
                dzikirPoin +
                taklimPoin +
                istighfarPoin +
                shalawatPoin) /
            16) *
        100;

    return finalPoin.roundToDouble();
  }

  double fardhuPoin(List<HiveYaumiModel> hiveYaumiModel, String bulan) {
    final yaumiModel = hiveYaumiModel
        .where((element) =>
            DateFormat('MMMM', "id_ID").format(element.tanggal!) == bulan)
        .toList();
    double myFardhuPoin = (yaumiModel
            .map((e) => e.shubuh)
            .toList()
            .fold(0.0, (p, e) => p + (e! ? 1.0 : 0.0))) +
        (yaumiModel
            .map((e) => e.dhuhur)
            .toList()
            .fold(0.0, (p, e) => p + (e! ? 1.0 : 0.0))) +
        (yaumiModel
            .map((e) => e.ashar)
            .toList()
            .fold(0.0, (p, e) => p + (e! ? 1.0 : 0.0))) +
        (yaumiModel
            .map((e) => e.maghrib)
            .toList()
            .fold(0.0, (p, e) => p + (e! ? 1.0 : 0.0))) +
        (yaumiModel
            .map((e) => e.isya)
            .toList()
            .fold(0.0, (p, e) => p + (e! ? 1.0 : 0.0)));
    return myFardhuPoin.roundToDouble();
  }

  double dzikirPoin(List<HiveYaumiModel> hiveYaumiModel, String bulan) {
    final yaumiModel = hiveYaumiModel
        .where((element) =>
            DateFormat('MMMM', "id_ID").format(element.tanggal!) == bulan)
        .toList();
    double myDzikirPoin = (yaumiModel
            .map((e) => e.dzikirPagi)
            .toList()
            .fold(0.0, (p, e) => p + (e! ? 1.0 : 0.0))) +
        (yaumiModel
            .map((e) => e.dzikirPetang)
            .toList()
            .fold(0.0, (p, e) => p + (e! ? 1.0 : 0.0)));
    return myDzikirPoin.roundToDouble();
  }

  double tahajudPoin(List<HiveYaumiModel> hiveYaumiModel, String bulan) {
    final yaumiModel = hiveYaumiModel
        .where((element) =>
            DateFormat('MMMM', "id_ID").format(element.tanggal!) == bulan)
        .toList();
    double myTahajudPoin = (yaumiModel
        .map((e) => e.tahajud)
        .toList()
        .fold(0.0, (p, e) => p + (e! ? 1.0 : 0.0)));
    return myTahajudPoin.roundToDouble();
  }

  double dhuhaPoin(List<HiveYaumiModel> hiveYaumiModel, String bulan) {
    final yaumiModel = hiveYaumiModel
        .where((element) =>
            DateFormat('MMMM', "id_ID").format(element.tanggal!) == bulan)
        .toList();
    double myPoin = (yaumiModel
        .map((e) => e.dhuha)
        .toList()
        .fold(0.0, (p, e) => p + (e! ? 1.0 : 0.0)));
    return myPoin.roundToDouble();
  }

  double rawatibPoin(List<HiveYaumiModel> hiveYaumiModel, String bulan) {
    final yaumiModel = hiveYaumiModel
        .where((element) =>
            DateFormat('MMMM', "id_ID").format(element.tanggal!) == bulan)
        .toList();
    double myPoin = (yaumiModel
        .map((e) => e.rawatib)
        .toList()
        .fold(0.0, (p, e) => p + (e! ? 1.0 : 0.0)));
    return myPoin.roundToDouble();
  }

  double tilawahPoin(List<HiveYaumiModel> hiveYaumiModel, String bulan) {
    final yaumiModel = hiveYaumiModel
        .where((element) =>
            DateFormat('MMMM', "id_ID").format(element.tanggal!) == bulan)
        .toList();
    double myPoin = (yaumiModel
        .map((e) => e.tilawah)
        .toList()
        .fold(0.0, (p, e) => p + (e! ? 1.0 : 0.0)));
    return myPoin.roundToDouble();
  }

  double shaumPoin(List<HiveYaumiModel> hiveYaumiModel, String bulan) {
    final yaumiModel = hiveYaumiModel
        .where((element) =>
            DateFormat('MMMM', "id_ID").format(element.tanggal!) == bulan)
        .toList();
    double myPoin = (yaumiModel
        .map((e) => e.shaum)
        .toList()
        .fold(0.0, (p, e) => p + (e! ? 1.0 : 0.0)));
    return myPoin.roundToDouble();
  }

  double sedekahPoin(List<HiveYaumiModel> hiveYaumiModel, String bulan) {
    final yaumiModel = hiveYaumiModel
        .where((element) =>
            DateFormat('MMMM', "id_ID").format(element.tanggal!) == bulan)
        .toList();
    double myPoin = (yaumiModel
        .map((e) => e.sedekah)
        .toList()
        .fold(0.0, (p, e) => p + (e! ? 1.0 : 0.0)));
    return myPoin.roundToDouble();
  }

  double taklimPoin(List<HiveYaumiModel> hiveYaumiModel, String bulan) {
    final yaumiModel = hiveYaumiModel
        .where((element) =>
            DateFormat('MMMM', "id_ID").format(element.tanggal!) == bulan)
        .toList();
    double myPoin = (yaumiModel
        .map((e) => e.taklim)
        .toList()
        .fold(0.0, (p, e) => p + (e! ? 1.0 : 0.0)));
    return myPoin.roundToDouble();
  }

  double istighfarPoin(List<HiveYaumiModel> hiveYaumiModel, String bulan) {
    final yaumiModel = hiveYaumiModel
        .where((element) =>
            DateFormat('MMMM', "id_ID").format(element.tanggal!) == bulan)
        .toList();
    double myPoin = (yaumiModel
        .map((e) => e.istighfar)
        .toList()
        .fold(0.0, (p, e) => p + (e! ? 1.0 : 0.0)));
    return myPoin.roundToDouble();
  }

  double shalawatPoin(List<HiveYaumiModel> hiveYaumiModel, String bulan) {
    final yaumiModel = hiveYaumiModel
        .where((element) =>
            DateFormat('MMMM', "id_ID").format(element.tanggal!) == bulan)
        .toList();
    double myPoin = (yaumiModel
        .map((e) => e.shalawat)
        .toList()
        .fold(0.0, (p, e) => p + (e! ? 1.0 : 0.0)));
    return myPoin.roundToDouble();
  }

  double totalPoin(
      List<HiveYaumiModel> hiveYaumiModel, String bulan, bool isNow) {
    final yaumiModel = hiveYaumiModel
        .where((element) =>
            DateFormat('MMMM', "id_ID").format(element.tanggal!) == bulan)
        .toList();
    final jumlahHari = DateUtils.getDaysInMonth(DateTime.now().year,
        isNow ? DateTime.now().month : DateTime.now().month - 1);
    double myPoin =
        yaumiModel.map((e) => e.point).fold(0.0, (p, e) => p + e!) / jumlahHari;
    return myPoin.roundToDouble();
  }
}
