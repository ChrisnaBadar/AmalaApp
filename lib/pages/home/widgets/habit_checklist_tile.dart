import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controller.dart';
import '../../../models/hive/hive_yaumi_active_model.dart';
import '../../../models/hive/hive_yaumi_model.dart';
import '../../home_habitChecklistDetails/controllers/habit_checklist_controller.dart';
import '../../home_habitChecklistDetails/habit_checklist_detail.dart';
import '../data/habit_checklist_data.dart';

final checklistData = HabitCheckListData();

Widget habitChecklistTile(
    HiveYaumiActiveModel hiveModel,
    int index,
    HabitChecklistController habitChecklistController,
    HomeController homeController,
    List<HiveYaumiModel> hiveYaumiModel,
    List iconCheck) {
  List<bool> checkActiveSettings = [
    hiveModel.fardhu!,
    hiveModel.tahajud!,
    hiveModel.dhuha!,
    hiveModel.rawatib!,
    hiveModel.tilawah!,
    hiveModel.shaum!,
    hiveModel.sedekah!,
    hiveModel.dzikir!,
    hiveModel.taklim!,
    hiveModel.istighfar!,
    hiveModel.shalawat!
  ];

  return HabitCheckListData(isActive: checkActiveSettings[index])
          .listTileDataParameter()[index]['isActive']
      ? ListTile(
          onTap: () {
            habitChecklistController.shownPoint.value = 0.0;
            Get.to(() => HabitCheckslistDetails(
                  category: HabitCheckListData().listTileDataParameter()[index]
                      ['category'],
                  homeController: homeController,
                  habitChecklistController: habitChecklistController,
                ));
          },
          leading: Obx(() => homeController.iconCheck[index]
              ? const Icon(
                  Icons.check_box,
                  color: Colors.green,
                )
              : const Icon(Icons.check_box_outline_blank)),
          title: Text(
              HabitCheckListData().listTileDataParameter()[index]['title'],
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          subtitle: Text(
              HabitCheckListData().listTileDataParameter()[index]
                  ['description'],
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.blueGrey)),
        )
      : Container();
}
