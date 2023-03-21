import 'package:amala/pages/absen/reports/absen_report_page.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:amala/constants/my_strings.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/hive/boxes.dart';
import '../../models/hive/hive_absen_model.dart';
import '../../services/admob_service.dart';
import 'absen_list.dart';
import 'controllers/absen_controller.dart';
import 'form/absen_form.dart';

class AbsenPage extends StatefulWidget {
  const AbsenPage({super.key});

  @override
  State<AbsenPage> createState() => _AbsenPageState();
}

class _AbsenPageState extends State<AbsenPage> {
  BannerAd? _bannerAd;

  final _absenController = Get.put(AbsenController());

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
    return Scaffold(
      bottomNavigationBar: _bannerAd == null
          ? Container()
          : Container(
              height: 52,
              margin: const EdgeInsets.only(bottom: 12),
              child: AdWidget(ad: _bannerAd!),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => AbsenForm(absenController: _absenController));
        },
        label: const Text('Absen'),
        icon: Image.asset(
          MyStrings.calenderIconColor,
          scale: 3,
        ),
      ),
      body: ValueListenableBuilder<Box<HiveAbsenModel>>(
        valueListenable: Boxes.getAbsenModel().listenable(),
        builder: (context, box, _) {
          final hiveAbsenModel = box.values.toList().cast<HiveAbsenModel>();
          final hiveAbsenMonthly = hiveAbsenModel
              .where((element) =>
                  DateFormat('MMMM yyyy', "id_ID").format(element.date!) ==
                  _absenController.choosenMonth.value)
              .toList();
          final hiveAbsenStatus = hiveAbsenMonthly
              .where((element) =>
                  element.kehadiran == _absenController.sortValue.value)
              .toList();
          final sortedItem = _absenController.sortValue.value == 'Semua'
              ? hiveAbsenMonthly
              : hiveAbsenStatus
            ..sort((a, b) => a.date!.compareTo(b.date!));
          return _mainBody(sortedItem);
        },
      ),
    );
  }

  Widget _mainBody(List<HiveAbsenModel> hiveAbsenModel) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            //Header Absen
            _headerAbsen(),

            //Bulan Dropdown
            _bulanDropdownSortir(),

            //List Absen
            Expanded(
              child: _absenList(hiveAbsenModel),
            )
          ],
        ),
      ),
    );
  }

  Widget _headerAbsen() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Absen Online',
              style: TextStyle(
                  fontSize: 17.5,
                  color: Colors.blueGrey[700],
                  fontWeight: FontWeight.bold)),
          TextButton.icon(
              onPressed: () => Get.to(() => const AbsenReportPage()),
              icon: Image.asset(
                MyStrings.docIconColor,
                scale: 3,
              ),
              label: const Text('Sheet'))
        ],
      ),
    );
  }

  Widget _bulanDropdownSortir() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => DropdownButton(
            items: List.generate(
                12,
                (index) => DropdownMenuItem(
                      value: DateFormat('MMMM yyyy', "id_ID")
                          .format(DateTime(DateTime.now().year, index + 1)),
                      child: Text(DateFormat('MMMM yyyy', "id_ID")
                          .format(DateTime(DateTime.now().year, index + 1))),
                    )),
            onChanged: (val) {
              setState(() {
                _absenController.choosenMonth.value = val!;
              });
            },
            value: _absenController.choosenMonth.value,
          ),
        ),
        Row(
          children: [
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _absenController.sortationControl();
                });
              },
              icon: Image.asset(
                MyStrings.filterIconColor,
                scale: 3,
              ),
              label: Obx(() => Text(_absenController.sortTitle.value)),
            ),
          ],
        )
      ],
    );
  }

  Widget _absenList(List<HiveAbsenModel> hiveAbsenModel) {
    if (hiveAbsenModel.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            MyStrings.content,
            opacity: const AlwaysStoppedAnimation(75),
            scale: 1.5,
          ),
          const SizedBox(
            height: 8.0,
          ),
          const Text(
            'Rekaman absen akan terlihat di sini.\nSetelah mengisi absen harian.',
            textAlign: TextAlign.center,
          )
        ],
      );
    } else {
      return SingleChildScrollView(
          child: AbsenList(
        hiveAbsenModel: hiveAbsenModel,
        absenController: _absenController,
      ));
    }
  }
}
