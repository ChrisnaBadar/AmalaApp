import 'package:amala/models/users_model.dart';
import 'package:amala/models/yaumi_model.dart';
import 'package:amala/pages/print_report/yaumi_report_tile.dart';
import 'package:amala/services/database_service.dart';
import 'package:amala/services/excelService.dart';
import 'package:flutter/material.dart';

import '../../blocs/bloc_exports.dart';

class YaumiPrintReportPage extends StatefulWidget {
  const YaumiPrintReportPage({super.key});

  @override
  State<YaumiPrintReportPage> createState() => _YaumiPrintReportPageState();
}

class _YaumiPrintReportPageState extends State<YaumiPrintReportPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return StreamBuilder<List<UsersModel>>(
            stream: DatabaseService().yaumiListModel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data;
                final userGroupData = userData!
                    .where((e) => e.uidGroup == state.uidGroup)
                    .toList();
                final yaumiData = userGroupData.map((e) => e.yaumi).toList();
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
                final testResult = myResult.map((e) => e.poinHariIni).toList();
                print('yaumiData.length: $myResult');
                return Scaffold(
                  body: SafeArea(
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
                      const Text('Tenggang laporan dari bulan ke bulan'),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Text('Tanggal'),
                            SizedBox(
                              width: 16.0,
                            ),
                            SizedBox(
                              width: 80.0,
                              child: DropdownButtonFormField(
                                value: '1',
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)))),
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                items: List.generate(
                                    12,
                                    (index) => DropdownMenuItem<String>(
                                        value: '${index + 1}',
                                        child: Text('${index + 1}'))),
                                onChanged: (Object? value) {},
                              ),
                            ),
                            Text(' Bulan sebelum - xx Bulan Berjalan'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 1,
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              const YaumiReportTile(),
                        ),
                      )
                      //LIst of report tile between months
                    ],
                  )),
                );
              } else {
                return Container();
              }
            });
      },
    );
  }
}
