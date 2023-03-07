import 'package:amala/constants/my_strings.dart';
import 'package:amala/pages/yaumiLog/yaumi_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../models/hive/hive_yaumi_active_model.dart';
import '../../models/hive/hive_yaumi_model.dart';
import 'controller/yaumi_log_controller.dart';
import 'data/log_data.dart';

class YaumiLogReport extends StatefulWidget {
  final List<HiveYaumiModel>? hiveYaumiModel;
  final HiveYaumiActiveModel? hiveYaumiActiveModel;
  const YaumiLogReport({this.hiveYaumiModel, this.hiveYaumiActiveModel});

  @override
  State<YaumiLogReport> createState() => _YaumiLogReportState();
}

class _YaumiLogReportState extends State<YaumiLogReport> {
  final User? _user = FirebaseAuth.instance.currentUser;
  final logController = Get.put(YaumiLogController());
  var hariIni = DateFormat('dd MMM yyyy', "id_ID").format(DateTime.now());
  var pekanLalu = DateFormat('dd MMM yyyy', "id_ID")
      .format(DateTime.now().subtract(Duration(days: 6)));
  var bulanIni = DateFormat('MMMM', "id_ID").format(DateTime.now());
  var bulanLalu = DateFormat('MMMM', "id_ID")
      .format(DateTime(DateTime.now().year, DateTime.now().month - 1));
  @override
  Widget build(BuildContext context) {
    var _chartLogData = LogData().chartModel(widget.hiveYaumiModel!);
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan Yaumi'),
        actions: [
          _user != null
              ? IconButton(
                  onPressed: () => Get.to(() => YaumiLog()),
                  icon: Image.asset(MyStrings.docIconColor, scale: 3))
              : Container()
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 16.0,
            ),
            Text('Aktifitas Ibadah Pekan Ini'),
            SizedBox(
              height: 16.0,
            ),
            Container(
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
                        getTitles: (value) => _chartLogData
                            .firstWhere(
                                (element) => element.id == value.toInt())
                            .name,
                        getTextStyles: (context, value) =>
                            TextStyle(fontSize: 12.0, color: Colors.green),
                      ),
                      leftTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, value) =>
                            TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    ),
                    maxY: 100,
                    minY: 0,
                    groupsSpace: 17,
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    barTouchData: BarTouchData(enabled: true),
                    barGroups: _chartLogData
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
              padding: EdgeInsets.only(left: 16.0),
              alignment: Alignment.centerLeft,
              child: Text.rich(TextSpan(
                  children: [
                    TextSpan(text: pekanLalu),
                    TextSpan(text: ' - '),
                    TextSpan(text: hariIni)
                  ],
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blueGrey))),
            ),
            SizedBox(
              height: 32.0,
            ),
            Text('Prestasi Ibadah'),
            SizedBox(
              height: 16.0,
            ),
            _prestasiIbadah()
          ],
        ),
      ),
    );
  }

  TextStyle _headerStyle() {
    return TextStyle(
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
                        '$bulanIni',
                        style: _headerStyle(),
                      ))),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        '$bulanLalu',
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
                      child: Text('Shalat Fardhu'))),
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
        Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text('Shalat Tahajud'))),
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
                      child: Text('Shalat Dhuha'))),
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
        Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text('Shalat Rawatib'))),
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
                      alignment: Alignment.center, child: Text('Tilawah'))),
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
        Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center, child: Text('Shaum'))),
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
                      alignment: Alignment.center, child: Text('Sedekah'))),
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
        Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center, child: Text('Dzikir'))),
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
                      alignment: Alignment.center, child: Text('Taklim'))),
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
        Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center, child: Text('Istighfar'))),
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
                      alignment: Alignment.center, child: Text('Shalawat'))),
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
