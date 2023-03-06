import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controller.dart';
import '../../../models/hive/hive_yaumi_active_model.dart';
import '../../../models/hive/hive_yaumi_model.dart';
import '../../home_habitChecklistDetails/controllers/habitChecklistController.dart';
import '../data/habitChecklistData.dart';
import 'habitChecklistTile.dart';

final checklistData = HabitCheckListData().listTileDataParameter();

Widget habitChecklist(
    {@required BuildContext? context,
    double spaceGap = 15.0,
    double progressValue = .5,
    @required Function? toYaumiSettings,
    @required Function? toYaumiLog,
    @required HabitChecklistController? habitChecklistController,
    @required HomeController? homeController,
    @required List? iconsCheck,
    @required List<HiveYaumiActiveModel>? yaumiActiveModel,
    @required List<HiveYaumiModel>? hiveYaumiModel}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        color: Colors.white),
    child: Column(
      children: [
        //progress bar target hari ini
        Obx(
          () => progressBarTarget(
              spaceGap, habitChecklistController!.shownPoint.value),
        ),

        //habit tracker settings
        habitTrackerSettings(context, toYaumiSettings, toYaumiLog),

        //listtile habit tracker
        listTileHabitTracker(
            context,
            spaceGap,
            yaumiActiveModel!,
            checklistData,
            habitChecklistController!,
            homeController!,
            hiveYaumiModel!,
            iconsCheck!),
      ],
    ),
  );
}

heightSpacing(spaceGap) {
  return SizedBox(
    height: spaceGap,
  );
}

progressBarTarget(spaceGap, progressValue) {
  var progress = progressValue / 100;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heightSpacing(spaceGap),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            progress == 0.0
                ? Container(
                    child:
                        Text('Login lalu Tap Save untuk merekam pencapaian.'),
                  )
                : Text('Progress pencapaian target habit hari ini:'),
            progress == 0.0
                ? Container(
                    height: 15.0,
                  )
                : Text('${(progress * 100).roundToDouble()} %')
          ],
        ),
        heightSpacing(spaceGap),
        LinearProgressIndicator(
          value: progress,
        )
      ],
    ),
  );
}

habitTrackerSettings(context, toYaumiSettings, toYaumiLog) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          onPressed: toYaumiLog,
          icon: Icon(
            Icons.list,
            color: Colors.blue,
          ),
          label: Text('Log Yaumi'),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.20,
          height: 3.5,
          decoration: BoxDecoration(color: Colors.blueGrey[100]),
        ),
        TextButton.icon(
          onPressed: toYaumiSettings,
          icon: Icon(
            Icons.settings,
            color: Colors.blue,
          ),
          label: Text('Settings'),
        )
      ],
    ),
  );
}

listTileHabitTracker(
    context,
    spaceGap,
    List<HiveYaumiActiveModel> yaumiActiveModel,
    checklistData,
    HabitChecklistController habitChecklistController,
    HomeController homeController,
    List<HiveYaumiModel> hiveYaumiModel,
    List iconCheck) {
  return Column(
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: checklistData.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return habitChecklistTile(
                yaumiActiveModel.first,
                index,
                habitChecklistController,
                homeController,
                hiveYaumiModel,
                iconCheck);
          },
        ),
      ),
    ],
  );
}
