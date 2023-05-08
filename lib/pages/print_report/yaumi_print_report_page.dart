import 'dart:ffi';

import 'package:amala/constants/my_strings.dart';
import 'package:amala/models/users_model.dart';
import 'package:amala/models/yaumi_model.dart';
import 'package:amala/pages/print_report/yaumi_report_tile.dart';
import 'package:amala/services/database_service.dart';
import 'package:amala/services/excelService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../blocs/bloc_exports.dart';

class YaumiPrintReportPage extends StatefulWidget {
  const YaumiPrintReportPage({super.key});

  @override
  State<YaumiPrintReportPage> createState() => _YaumiPrintReportPageState();
}

class _YaumiPrintReportPageState extends State<YaumiPrintReportPage> {
  final _textController = TextEditingController();
  static var monthNow = DateTime.now();
  static var selectedMonth = DateTime(monthNow.year, monthNow.month);

  List<DateTime> months =
      List.generate(12, (index) => DateTime(DateTime.now().year, index + 1));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (settingsContext, settingsState) {
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return StreamBuilder<List<UsersModel>>(
                stream: DatabaseService().yaumiListModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    //TODO: Buat list data untuk tanggal sekarang dan sebelum.....
                    final userData = snapshot.data;
                    final userGroupData = userData!
                        .where((e) => e.uidGroup == state.uidGroup)
                        .toList();
                    final yaumiData =
                        userGroupData.map((e) => e.yaumi).toList();
                    final result = List.generate(
                        yaumiData.length,
                        (index) => yaumiData
                            .map((e) => e!.values)
                            .toList()[index]
                            .toList()).expand((element) => element).toList();
                    final myResult = List.generate(
                        result.length,
                        (index) => YaumiModel(
                            date: result[index]['date'].toDate(),
                            nama: result[index]['nama'],
                            id: result[index]['tanggal'],
                            shubuh: result[index]['shubuh'],
                            dhuhur: result[index]['dhuhur'],
                            ashar: result[index]['ashar'],
                            maghrib: result[index]['maghrib'],
                            isya: result[index]['isya'],
                            tahajud: result[index]['tahajud'],
                            rawatib: result[index]['rawatib'],
                            dhuha: result[index]['dhuha'],
                            tilawah: result[index]['tilawah'],
                            shaum: result[index]['shaum'],
                            sedekah: result[index]['sedekah'],
                            dzikirPagi: result[index]['dzikirPagi'],
                            dzikirPetang: result[index]['dzikirPetang'],
                            taklim: result[index]['taklim'],
                            istighfar: result[index]['istighfar'],
                            shalawat: result[index]['shalawat'],
                            poinHariIni: result[index]['point'],
                            isSubmitted: result[index]['isSaved']));
                    return Scaffold(
                      backgroundColor: Colors.indigo[50],
                      body: SafeArea(
                          child: SingleChildScrollView(
                        child: Column(
                          children: [
                            //Title
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Laporan Ibadah Harian Group',
                                style: TextStyle(
                                    color: Colors.blueGrey[700],
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Tanggal',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 4.0,
                                        ),
                                        DropdownButtonFormField(
                                          value:
                                              settingsState.reportSelectedDate,
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)))),
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.deepPurple),
                                          items: List.generate(
                                              28,
                                              (index) => DropdownMenuItem<int>(
                                                  value: index + 1,
                                                  child: Text('${index + 1}'))),
                                          onChanged: (value) {
                                            context.read<SettingsBloc>().add(
                                                SetReportSelectedDateEvent(
                                                    date: value!));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Bulan',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 4.0,
                                        ),
                                        DropdownButtonFormField(
                                            value: selectedMonth,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)))),
                                            items: months
                                                .map<DropdownMenuItem>((e) {
                                              return DropdownMenuItem(
                                                  value: e,
                                                  child: Text(DateFormat(
                                                          'MMMM yyyy', "id_ID")
                                                      .format(e)));
                                            }).toList(),
                                            onChanged: (val) {
                                              setState(() {
                                                selectedMonth = val!;
                                              });
                                            }),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Nama Lembaga',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 4.0,
                                  ),
                                  SizedBox(
                                    height: 60.0,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          hintText: settingsState.namaLembaga),
                                      controller: _textController,
                                      onChanged: (val) {
                                        context.read<SettingsBloc>().add(
                                            SetNamaLembagaEvent(
                                                namaLembaga: val));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      'CONTOH LAPORAN SPREADSHEET',
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Laporan Bulanan Yaumi ${settingsState.namaLembaga}',
                                            style: TextStyle(
                                                color: Colors.blueGrey[800],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17.0),
                                          ),
                                          Text(
                                            '${settingsState.reportSelectedDate} ${DateFormat('MMMM yyyy', "id_ID").format(selectedMonth)} - ${settingsState.reportSelectedDate - 1} ${DateFormat('MMMM yyyy', "id_ID").format(DateTime(selectedMonth.year, selectedMonth.month + 1))}',
                                            style: TextStyle(
                                                color: Colors.blueGrey[600],
                                                fontSize: 13.0),
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Image.asset(MyStrings.sampleSheet)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            YaumiReportTile(
                              prevMonth:
                                  '${settingsState.reportSelectedDate} ${DateFormat('MMMM yyyy', "id_ID").format(selectedMonth)}',
                              currentMonth:
                                  '${settingsState.reportSelectedDate + 1} ${DateFormat('MMMM yyyy', "id_ID").format(DateTime(selectedMonth.year, selectedMonth.month + 1))}',
                              month: DateFormat('MMMM yyyy', "id_ID")
                                  .format(selectedMonth),
                              myResult: myResult,
                              namaLembaga: settingsState.namaLembaga,
                              myDate: DateTime(
                                  selectedMonth.year,
                                  selectedMonth.month,
                                  settingsState.reportSelectedDate),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Laporan spreadsheet untuk saat ini hanya bisa dibuka menggunakan Google Sheet, jika tabel terjadi error ikuti langkah yang dijelaskan di dalam spreadsheet. Laporan kemudian bisa di export melalui Google Sheet menjadi format pilihan pengguna (Excel, Open Sheet, WPS, etc).\nTerima Kasih',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'Raleway',
                                    color: Colors.green[800]),
                              ),
                            )
                          ],
                        ),
                      )),
                    );
                  } else {
                    return Container();
                  }
                });
          },
        );
      },
    );
  }
}
