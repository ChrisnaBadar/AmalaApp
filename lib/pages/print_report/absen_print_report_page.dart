import 'package:amala/constants/my_strings.dart';
import 'package:amala/models/absen_model.dart';
import 'package:amala/models/users_model.dart';
import 'package:amala/pages/print_report/absen_report_tile.dart';
import 'package:amala/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../blocs/bloc_exports.dart';

class AbsenPrintReportPage extends StatefulWidget {
  const AbsenPrintReportPage({super.key});

  @override
  State<AbsenPrintReportPage> createState() => _AbsenPrintReportPageState();
}

class _AbsenPrintReportPageState extends State<AbsenPrintReportPage> {
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
                stream: DatabaseService().absenListModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final userData = snapshot.data;
                    final userGroupData = userData!
                        .where((e) => e.uidGroup == state.uidGroup)
                        .toList();
                    final absenData =
                        userGroupData.map((e) => e.absen).toList();
                    final result = List.generate(
                        absenData.length,
                        (index) => absenData
                            .map((e) => e!.values)
                            .toList()[index]
                            .toList()).expand((element) => element).toList();
                    final myResult = List.generate(
                        result.length,
                        (index) => AbsenModel(
                            date: result[index]['date'].toDate(),
                            tanggal: result[index]['tanggal'],
                            nama: result[index]['nama'],
                            waktu: result[index]['waktu'],
                            lokasi: result[index]['lokasi'],
                            kehadiran: result[index]['kehadiran'],
                            tanggalIjin: result[index]['tanggalIjin'],
                            keperluan: result[index]['keperluan']));
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
                                'Laporan Absen Online Group',
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
                                            'Laporan Bulanan Absen Online ${settingsState.namaLembaga}',
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
                            AbsenReportTile(
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
