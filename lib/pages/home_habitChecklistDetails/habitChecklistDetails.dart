import 'package:amala/controllers/home_controller.dart';
import 'package:amala/pages/home_habitChecklistDetails/widgets/checklistDetailsWidget.dart';
import 'package:amala/pages/home_habitChecklistDetails/widgets/habitChecklistDetailsHeader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/hive/boxes.dart';
import '../../models/hive/hive_yaumi_active_model.dart';
import '../../models/hive/hive_yaumi_model.dart';
import 'controllers/habitChecklistController.dart';
import 'data/habitChecklistDetailsData.dart';

class HabitCheckslistDetails extends StatefulWidget {
  String? category;
  DateTime? tanggal;
  HomeController? homeController;
  HabitChecklistController? habitChecklistController;
  HabitCheckslistDetails(
      {this.category,
      this.tanggal,
      this.homeController,
      this.habitChecklistController});

  @override
  State<HabitCheckslistDetails> createState() => _HabitCheckslistDetailsState();
}

class _HabitCheckslistDetailsState extends State<HabitCheckslistDetails> {
  final _data = HabitChecklistDetailsData();
  @override
  Widget build(BuildContext context) {
    final habitChecklistController = widget.habitChecklistController;
    final homeController = widget.homeController;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Header
            habitChecklistDetailsHeader(
                context: context,
                habitChecklistController: habitChecklistController),

            SizedBox(
              height: 16.0,
            ),
            //kategori widgets
            ValueListenableBuilder<Box<HiveYaumiActiveModel>>(
              valueListenable: Boxes.getYaumiActiveModel().listenable(),
              builder: (context, box, _) {
                final hiveYaumiActiveModel =
                    box.values.toList().cast<HiveYaumiActiveModel>();
                if (hiveYaumiActiveModel.isEmpty) {
                  return Container();
                } else {
                  return ValueListenableBuilder<Box<HiveYaumiModel>>(
                      valueListenable: Boxes.getYaumiModel().listenable(),
                      builder: (context, box, __) {
                        final hiveYaumiModel =
                            box.values.toList().cast<HiveYaumiModel>();
                        final hiveYaumiModelSingleDate = hiveYaumiModel
                            .where((element) =>
                                element.tanggal ==
                                homeController!.selectedDate.value)
                            .toList();
                        if (hiveYaumiModelSingleDate.isEmpty) {
                          habitChecklistController!
                              .setFirstData(homeController!.selectedDate.value);
                          return Container();
                        } else {
                          habitChecklistController!.setHiveData(
                              hiveYaumiModelSingleDate,
                              homeController!.selectedDate.value);
                          return checklistDetailsWidgets(
                              category: widget.category,
                              tanggal: widget.tanggal,
                              habitController: habitChecklistController,
                              homeController: homeController,
                              hiveYaumiActiveModel: hiveYaumiActiveModel.first);
                        }
                      });
                }
              },
            ),
            SizedBox(
              height: 16.0,
            )
          ],
        ),
      ),
    );
  }
}
