import 'package:amala/models/users_model.dart';
import 'package:amala/models/yaumi_model.dart';
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
                  body: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              ExcelService().generateYaumiSheet(
                                  yaumiModel: myResult,
                                  myDate: DateTime(2023, 4, 11),
                                  lembaga: '-',
                                  context: context);
                            },
                            child: Text('Generate Report'))
                      ],
                    ),
                  ),
                );
              } else {
                return Container();
              }
            });
      },
    );
  }
}
