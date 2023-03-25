import 'package:amala/constants/my_strings.dart';
import 'package:amala/pages/yaumiLog/yaumi_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../models/hive/hive_yaumi_active_model.dart';
import '../../models/hive/hive_yaumi_model.dart';
import '../../services/admob_service.dart';
import 'controller/yaumi_log_controller.dart';
import 'data/log_data.dart';

class YaumiLogReport extends StatefulWidget {
  final List<HiveYaumiModel>? hiveYaumiModel;
  final HiveYaumiActiveModel? hiveYaumiActiveModel;
  const YaumiLogReport(
      {super.key, this.hiveYaumiModel, this.hiveYaumiActiveModel});

  @override
  State<YaumiLogReport> createState() => _YaumiLogReportState();
}

class _YaumiLogReportState extends State<YaumiLogReport> {
  final User? _user = FirebaseAuth.instance.currentUser;
  final logController = Get.put(YaumiLogController());
  var hariIni = DateFormat('dd MMM yyyy', "id_ID").format(DateTime.now());
  var pekanLalu = DateFormat('dd MMM yyyy', "id_ID")
      .format(DateTime.now().subtract(const Duration(days: 6)));
  var bulanIni = DateFormat('MMMM', "id_ID").format(DateTime.now());
  var bulanLalu = DateFormat('MMMM', "id_ID")
      .format(DateTime(DateTime.now().year, DateTime.now().month - 1));

  //admob
  BannerAd? _bannerAd;
  //InterstitialAd? _interstitialAd;

  // void _createIntertitialAd() {
  //   InterstitialAd.load(
  //       adUnitId: AdMobService.interstitialAdUnitId,
  //       request: const AdRequest(),
  //       adLoadCallback: InterstitialAdLoadCallback(
  //         onAdLoaded: (ad) => _interstitialAd = ad,
  //         onAdFailedToLoad: (LoadAdError error) => _interstitialAd = null,
  //       ));
  // }

  // void _showInterstitialAd() {
  //   if (_interstitialAd != null) {
  //     _interstitialAd!.fullScreenContentCallback =
  //         FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
  //       ad.dispose();
  //       logController.loading.value = true;
  //       _createIntertitialAd();
  //       Get.to(() => const YaumiLog());
  //     }, onAdFailedToShowFullScreenContent: (ad, e) {
  //       ad.dispose();
  //       logController.loading.value = true;
  //       _createIntertitialAd();
  //       Get.to(() => const YaumiLog());
  //     });
  //     _interstitialAd!.show();
  //     _interstitialAd = null;
  //   }
  // }

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
    //_createIntertitialAd();
    logController.loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    var chartLogData = LogData().chartModel(widget.hiveYaumiModel!);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Yaumi'),
        actions: [
          _user != null
              ? IconButton(
                  onPressed: () {
                    logController.loading.value = true;
                    Get.to(() => const YaumiLog());
                  },
                  icon: Image.asset(MyStrings.docIconColor, scale: 3))
              : Container()
        ],
      ),
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
            const SizedBox(
              height: 16.0,
            ),
            const Text('Aktifitas Ibadah Pekan Ini'),
            const SizedBox(
              height: 16.0,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .25,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BarChart(BarChartData(
                    alignment: BarChartAlignment.spaceEvenly,
                    titlesData: FlTitlesData(
                      topTitles: SideTitles(showTitles: false),
                      rightTitles: SideTitles(showTitles: false),
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTitles: (value) => chartLogData
                            .firstWhere(
                                (element) => element.id == value.toInt())
                            .name,
                        getTextStyles: (context, value) => const TextStyle(
                            fontSize: 12.0, color: Colors.green),
                      ),
                      leftTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, value) =>
                            const TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    ),
                    maxY: 100,
                    minY: 0,
                    groupsSpace: 17,
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    barTouchData: BarTouchData(enabled: true),
                    barGroups: chartLogData
                        .map((e) => BarChartGroupData(x: e.id, barRods: [
                              BarChartRodData(
                                  colors: [Colors.grey],
                                  y: e.y,
                                  width: 22,
                                  borderRadius: BorderRadius.zero)
                            ]))
                        .toList())),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16.0),
              alignment: Alignment.centerLeft,
              child: Text.rich(TextSpan(
                  children: [
                    TextSpan(text: pekanLalu),
                    const TextSpan(text: ' - '),
                    TextSpan(text: hariIni)
                  ],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blueGrey))),
            ),
            const SizedBox(
              height: 32.0,
            ),
            const Text('Prestasi Ibadah'),
            const SizedBox(
              height: 16.0,
            ),
            _prestasiIbadah()
          ],
        ),
      ),
    );
  }

  TextStyle _headerStyle() {
    return const TextStyle(
        fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.white);
  }

  Widget _prestasiIbadah() {
    return Column(
      children: [
        Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[700],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Category',
                        style: _headerStyle(),
                      ))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        bulanIni,
                        style: _headerStyle(),
                      ))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        bulanLalu,
                        style: _headerStyle(),
                      ))),
            ],
          ),
        ),
        Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[400],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: const Text('Shalat Fardhu'))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(logController
                          .fardhuPoin(widget.hiveYaumiModel!, bulanIni)
                          .toString()))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(logController
                          .fardhuPoin(widget.hiveYaumiModel!, bulanLalu)
                          .toString()))),
            ],
          ),
        ),
        SizedBox(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: const Text('Shalat Tahajud'))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(logController
                          .tahajudPoin(widget.hiveYaumiModel!, bulanIni)
                          .toString()))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(logController
                          .tahajudPoin(widget.hiveYaumiModel!, bulanLalu)
                          .toString()))),
            ],
          ),
        ),
        Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[400],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: const Text('Shalat Dhuha'))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(logController
                          .dhuhaPoin(widget.hiveYaumiModel!, bulanIni)
                          .toString()))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(logController
                          .dhuhaPoin(widget.hiveYaumiModel!, bulanLalu)
                          .toString()))),
            ],
          ),
        ),
        SizedBox(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: const Text('Shalat Rawatib'))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(logController
                          .rawatibPoin(widget.hiveYaumiModel!, bulanIni)
                          .toString()))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(logController
                          .rawatibPoin(widget.hiveYaumiModel!, bulanLalu)
                          .toString()))),
            ],
          ),
        ),
        Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[400],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: const Text('Tilawah'))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(logController
                          .tilawahPoin(widget.hiveYaumiModel!, bulanIni)
                          .toString()))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(logController
                          .tilawahPoin(widget.hiveYaumiModel!, bulanLalu)
                          .toString()))),
            ],
          ),
        ),
        SizedBox(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center, child: const Text('Shaum'))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(logController
                          .shaumPoin(widget.hiveYaumiModel!, bulanIni)
                          .toString()))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(logController
                          .shaumPoin(widget.hiveYaumiModel!, bulanLalu)
                          .toString()))),
            ],
          ),
        ),
        Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[400],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: const Text('Sedekah'))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(logController
                          .sedekahPoin(widget.hiveYaumiModel!, bulanIni)
                          .toString()))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(logController
                          .sedekahPoin(widget.hiveYaumiModel!, bulanLalu)
                          .toString()))),
            ],
          ),
        ),
        SizedBox(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: const Text('Dzikir'))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(logController
                          .dzikirPoin(widget.hiveYaumiModel!, bulanIni)
                          .toString()))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(logController
                          .dzikirPoin(widget.hiveYaumiModel!, bulanLalu)
                          .toString()))),
            ],
          ),
        ),
        Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[400],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: const Text('Taklim'))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(logController
                          .taklimPoin(widget.hiveYaumiModel!, bulanIni)
                          .toString()))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(logController
                          .taklimPoin(widget.hiveYaumiModel!, bulanLalu)
                          .toString()))),
            ],
          ),
        ),
        SizedBox(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: const Text('Istighfar'))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(logController
                          .istighfarPoin(widget.hiveYaumiModel!, bulanIni)
                          .toString()))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(logController
                          .istighfarPoin(widget.hiveYaumiModel!, bulanLalu)
                          .toString()))),
            ],
          ),
        ),
        Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[400],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: const Text('Shalawat'))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(logController
                          .shalawatPoin(widget.hiveYaumiModel!, bulanIni)
                          .toString()))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(logController
                          .shalawatPoin(widget.hiveYaumiModel!, bulanLalu)
                          .toString()))),
            ],
          ),
        ),
        Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[800],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Final%',
                        style: _headerStyle(),
                      ))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                          '${logController.totalPoin(widget.hiveYaumiModel!, bulanIni, true)} %',
                          style: _headerStyle()))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                          '${logController.totalPoin(widget.hiveYaumiModel!, bulanLalu, false)} %',
                          style: _headerStyle()))),
            ],
          ),
        ),
      ],
    );
  }
}
