import 'package:amala/controllers/home_controller.dart';
import 'package:amala/pages/home_habitChecklistDetails/widgets/checklist_detail_widget.dart';
import 'package:amala/pages/home_habitChecklistDetails/widgets/habit_checklist_detail_header.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/hive/boxes.dart';
import '../../models/hive/hive_yaumi_active_model.dart';
import '../../models/hive/hive_yaumi_model.dart';
import '../../services/admob_service.dart';
import 'controllers/habit_checklist_controller.dart';

class HabitCheckslistDetails extends StatefulWidget {
  final String? category;
  final DateTime? tanggal;
  final HomeController? homeController;
  final HabitChecklistController? habitChecklistController;
  const HabitCheckslistDetails(
      {super.key,
      this.category,
      this.tanggal,
      this.homeController,
      this.habitChecklistController});

  @override
  State<HabitCheckslistDetails> createState() => _HabitCheckslistDetailsState();
}

class _HabitCheckslistDetailsState extends State<HabitCheckslistDetails> {
  BannerAd? _bannerAd;

  void _createBannerAd() {
    _bannerAd = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: AdMobService.bannerAdUnitId,
        listener: AdMobService.bannerListener,
        request: const AdRequest())
      ..load();
  }

  @override
  void initState() {
    super.initState();
    _createBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    final habitChecklistController = widget.habitChecklistController;
    final homeController = widget.homeController;
    return Scaffold(
      bottomNavigationBar: _bannerAd == null
          ? Container()
          : Container(
              height: 52,
              margin: const EdgeInsets.only(bottom: 12),
              child: AdWidget(ad: _bannerAd!),
            ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Header
            habitChecklistDetailsHeader(
                context: context,
                habitChecklistController: habitChecklistController),

            const SizedBox(
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
            const SizedBox(
              height: 16.0,
            )
          ],
        ),
      ),
    );
  }
}
