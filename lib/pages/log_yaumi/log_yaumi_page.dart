import 'package:amala/models/users_model.dart';
import 'package:amala/models/yaumi_model.dart';
import 'package:amala/pages/log_yaumi/log_yaumi_list.dart';
import 'package:amala/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../blocs/bloc_exports.dart';
import '../../constants/my_strings.dart';

class LogYaumiPage extends StatefulWidget {
  const LogYaumiPage({super.key});

  @override
  State<LogYaumiPage> createState() => _LogYaumiPageState();
}

class _LogYaumiPageState extends State<LogYaumiPage> {
  List<String> months = List.generate(
      12,
      (index) => DateFormat('MMMM yyyy', "id_ID")
          .format(DateTime(DateTime.now().year, index + 1)));
  String dropdownValue = DateFormat('MMMM yyyy', "id_ID")
      .format(DateTime(DateTime.now().year, DateTime.now().month));
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (userContext, userState) {
        return StreamBuilder<UsersModel>(
            stream: DatabaseService(uid: userState.uid).yaumiModel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data;
                final yaumiData =
                    userData!.yaumi!.entries.map((e) => e.value).toList();
                final yaumiDateModel = List.generate(
                    yaumiData.length,
                    (index) => YaumiModel(
                          id: yaumiData[index]['tanggal'],
                          date: (yaumiData[index]['date']).toDate(),
                          nama: (yaumiData[index]['nama']),
                          shubuh: yaumiData[index]['shubuh'],
                          dhuhur: yaumiData[index]['dhuhur'],
                          ashar: yaumiData[index]['ashar'],
                          maghrib: yaumiData[index]['maghrib'],
                          isya: yaumiData[index]['isya'],
                          rawatib: yaumiData[index]['rawatib'],
                          tahajud: yaumiData[index]['tahajud'],
                          dhuha: yaumiData[index]['dhuha'],
                          tilawah: yaumiData[index]['tilawah'],
                          shaum: yaumiData[index]['shaum'],
                          sedekah: yaumiData[index]['sedekah'],
                          taklim: yaumiData[index]['taklim'],
                          dzikirPagi: yaumiData[index]['dzikirPagi'],
                          dzikirPetang: yaumiData[index]['dzikirPetang'],
                          istighfar: yaumiData[index]['istighfar'],
                          shalawat: yaumiData[index]['shalawat'],
                          poinHariIni: yaumiData[index]['point'],
                          isSubmitted: yaumiData[index]['isSaved'],
                        ));
                final selectedDateData = yaumiDateModel
                    .where((e) =>
                        DateFormat('MMMM yyyy', "id_ID").format(e.date) ==
                        dropdownValue)
                    .toList();
                final sortedItems = selectedDateData
                  ..sort((a, b) => b.date.compareTo(a.date));
                return Scaffold(
                    body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        //Header Absen
                        _headerLog(sortedItems),

                        //Bulan Dropdown
                        _bulanDropdownSortir(months),

                        //List Absen
                        Expanded(
                          child: LogYaumiList(allYaumis: sortedItems),
                        ),
                      ],
                    ),
                  ),
                ));
              } else {
                return const Scaffold(
                  body: Center(
                    child: Text('no data'),
                  ),
                );
              }
            });
      },
    );
  }

  Widget _headerLog(List<YaumiModel> sortedItems) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Data Yaumi Online',
              style: TextStyle(
                  fontSize: 17.5,
                  color: Colors.blueGrey[700],
                  fontWeight: FontWeight.bold)),
          TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/yaumiPrintReportPage',
                    arguments: sortedItems);
              },
              icon: Image.asset(
                MyStrings.docIconColor,
                scale: 3,
              ),
              label: const Text('Online Data Report'))
        ],
      ),
    );
  }

  Widget _bulanDropdownSortir(List<String> months) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DropdownButton<String>(
            value: dropdownValue,
            items: months.map<DropdownMenuItem<String>>((e) {
              return DropdownMenuItem(value: e, child: Text(e));
            }).toList(),
            onChanged: (val) {
              setState(() {
                dropdownValue = val!;
              });
            }),
      ],
    );
  }
}
