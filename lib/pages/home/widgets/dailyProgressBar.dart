import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../controllers/home_controller.dart';
import '../../../models/hive/hive_yaumi_model.dart';
import '../../home_habitChecklistDetails/controllers/habitChecklistController.dart';

Widget dailyProgressBar(
    {@required BuildContext? context,
    @required HomeController? homeController,
    @required HabitChecklistController? habitController,
    @required List<HiveYaumiModel>? hiveYaumiModel}) {
  return hiveYaumiModel!.isEmpty
      ? DatePicker(
          DateTime.now().subtract(Duration(days: 5)),
          initialSelectedDate: DateTime.now(),
          selectionColor: Color.fromARGB(255, 14, 76, 170),
          selectedTextColor: Colors.white,
          onDateChange: (date) {
            habitController!.shownPoint.value = 0.0;
            homeController!.selectedDate.value = date;
          },
          locale: "id_ID",
          daysCount: 8,
          inactiveDates: List.generate(
              2, (index) => DateTime.now().add(Duration(days: index + 1))),
        )
      : DatePicker(
          DateTime.now().subtract(Duration(days: 5)),
          initialSelectedDate: DateTime.now(),
          selectionColor: Color.fromARGB(255, 13, 74, 164),
          selectedTextColor: Colors.white,
          onDateChange: (date) {
            habitController!.shownPoint.value = 0.0;
            homeController!.selectedDate.value = date;
            var hiveYaumiModelSingleDate = hiveYaumiModel
                .where((element) => element.tanggal == date)
                .toList();
            var _result = hiveYaumiModelSingleDate
                .map(
                  (e) => e.isSaved,
                )
                .toList();
            if (hiveYaumiModelSingleDate.isEmpty) {
              homeController.isSaved.value = true;
              homeController.iconCheck.value =
                  List.generate(11, (index) => false);
              return;
            } else {
              homeController.isSaved.value = _result.first!;
              homeController.checkListResult.value = hiveYaumiModelSingleDate;
              habitController.shubuh.value =
                  hiveYaumiModelSingleDate.first.shubuh!;
              habitController.dhuhur.value =
                  hiveYaumiModelSingleDate.first.dhuhur!;
              habitController.ashar.value =
                  hiveYaumiModelSingleDate.first.ashar!;
              habitController.maghrib.value =
                  hiveYaumiModelSingleDate.first.maghrib!;
              habitController.isya.value = hiveYaumiModelSingleDate.first.isya!;
              habitController.tahajud.value =
                  hiveYaumiModelSingleDate.first.tahajud!;
              habitController.dhuha.value =
                  hiveYaumiModelSingleDate.first.dhuha!;
              habitController.rawatib.value =
                  hiveYaumiModelSingleDate.first.rawatib!;
              habitController.tilawah.value =
                  hiveYaumiModelSingleDate.first.tilawah!;
              habitController.shaum.value =
                  hiveYaumiModelSingleDate.first.shaum!;
              habitController.sedekah.value =
                  hiveYaumiModelSingleDate.first.sedekah!;
              habitController.dzikirPagi.value =
                  hiveYaumiModelSingleDate.first.dzikirPagi!;
              habitController.dzikirPetang.value =
                  hiveYaumiModelSingleDate.first.dzikirPetang!;
              habitController.taklim.value =
                  hiveYaumiModelSingleDate.first.taklim!;
              habitController.istighfar.value =
                  hiveYaumiModelSingleDate.first.istighfar!;
              habitController.shalawat.value =
                  hiveYaumiModelSingleDate.first.shalawat!;
              var cShubuh = homeController.checkListResult.first.shubuh,
                  cDhuhur = homeController.checkListResult.first.dhuhur,
                  cAshar = homeController.checkListResult.first.ashar,
                  cMaghrib = homeController.checkListResult.first.maghrib,
                  cIsya = homeController.checkListResult.first.isya,
                  cTahajud = homeController.checkListResult.first.tahajud,
                  cDhuha = homeController.checkListResult.first.dhuha,
                  cRawatib = homeController.checkListResult.first.rawatib,
                  cTilawah = homeController.checkListResult.first.tilawah,
                  cShaum = homeController.checkListResult.first.shaum,
                  cSedekah = homeController.checkListResult.first.sedekah,
                  cDzikirPagi = homeController.checkListResult.first.dzikirPagi,
                  cDzikirPetang =
                      homeController.checkListResult.first.dzikirPetang,
                  cTaklim = homeController.checkListResult.first.taklim,
                  cIstighfar = homeController.checkListResult.first.istighfar,
                  cShalawat = homeController.checkListResult.first.shalawat;
              List iconCheck = [
                [cShubuh, cDhuhur, cAshar, cMaghrib, cIsya].contains(true)
                    ? true
                    : false,
                cTahajud,
                cDhuha,
                cRawatib,
                cTilawah,
                cShaum,
                cSedekah,
                [cDzikirPagi, cDzikirPetang].contains(true) ? true : false,
                cTaklim,
                cIstighfar,
                cShalawat
              ];
              homeController.iconCheck.value = iconCheck;
            }
          },
          locale: "id_ID",
          daysCount: 8,
          inactiveDates: List.generate(
              2, (index) => DateTime.now().add(Duration(days: index + 1))),
        );
}
