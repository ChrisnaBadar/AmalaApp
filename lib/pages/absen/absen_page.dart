import 'package:amala/constants/core_data.dart';
import 'package:amala/models/absen_model.dart';
import 'package:amala/pages/absen/widgets/absen_list.dart';
import 'package:amala/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../blocs/bloc_exports.dart';
import '../../constants/my_strings.dart';
import '../../models/users_model.dart';

class AbsenPage extends StatefulWidget {
  const AbsenPage({super.key});

  @override
  State<AbsenPage> createState() => _AbsenPageState();
}

class _AbsenPageState extends State<AbsenPage> {
  String filterKehadiran = 'all';
  List<String> months = List.generate(
      12,
      (index) => DateFormat('MMMM yyyy', "id_ID")
          .format(DateTime(DateTime.now().year, index + 1)));
  String dropdownValue = DateFormat('MMMM yyyy', "id_ID")
      .format(DateTime(DateTime.now().year, DateTime.now().month));
  @override
  Widget build(BuildContext context) {
    String filterKehadiranTitle = filterKehadiran == CoreData.list[0]
        ? 'WFO'
        : filterKehadiran == CoreData.list[1]
            ? 'Ijin'
            : filterKehadiran == CoreData.list[2]
                ? 'Sakit'
                : filterKehadiran == CoreData.list[3]
                    ? 'WFH'
                    : 'All';
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return BlocBuilder<AbsenBloc, AbsenState>(
          builder: (context, absenState) {
            return StreamBuilder<UsersModel>(
                stream: DatabaseService(uid: state.uid).absenModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final userModel = snapshot.data;
                    final userData =
                        userModel!.absen!.entries.map((e) => e.value).toList();
                    final absenData = List.generate(
                        userData.length,
                        (index) => AbsenModel(
                            date: (userData[index]['date']).toDate(),
                            tanggal: userData[index]['tanggal'],
                            nama: userData[index]['nama'],
                            waktu: userData[index]['waktu'],
                            lokasi: userData[index]['lokasi'],
                            kehadiran: userData[index]['kehadiran'],
                            tanggalIjin: userData[index]['tanggalIjin'],
                            keperluan: userData[index]['keperluan']));
                    var sortedMonth = absenData
                        .where((e) =>
                            DateFormat('MMMM yyyy', "id_ID").format(e.date) ==
                            dropdownValue)
                        .toList();
                    var sortedDate = sortedMonth
                      ..sort((a, b) => b.date.compareTo(a.date));
                    var sortedAbsen = filterKehadiran != 'all'
                        ? sortedDate
                            .where(
                              (e) => e.kehadiran == filterKehadiran,
                            )
                            .toList()
                        : sortedDate;
                    var todayAbsen = sortedAbsen
                        .where(
                          (e) =>
                              e.date ==
                              DateTime(DateTime.now().year,
                                  DateTime.now().month, DateTime.now().day),
                        )
                        .toList();
                    return Scaffold(
                      floatingActionButton: todayAbsen.isEmpty
                          ? FloatingActionButton.extended(
                              onPressed: () {
                                Navigator.pushNamed(context, '/absenForm');
                              },
                              label: const Text('Absen'),
                              icon: Image.asset(
                                MyStrings.calenderIconColor,
                                scale: 3,
                              ),
                            )
                          : Container(),
                      body: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              //Header Absen
                              _headerAbsen(),

                              //Bulan Dropdown
                              _bulanDropdownSortir(
                                  months, filterKehadiranTitle),

                              //List Absen
                              Expanded(
                                child: _absenList(sortedAbsen),
                              )
                            ],
                          ),
                        ),
                      ),
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
              onPressed: () {
                Navigator.pushNamed(context, '/logAbsen');
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

  Widget _bulanDropdownSortir(
      List<String> months, String filterKehadiranTitle) {
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
        Row(
          children: [
            TextButton.icon(
              onPressed: () {
                if (filterKehadiran == 'all') {
                  setState(() {
                    filterKehadiran = CoreData.list[0];
                  });
                } else if (filterKehadiran == CoreData.list[0]) {
                  setState(() {
                    filterKehadiran = CoreData.list[1];
                  });
                } else if (filterKehadiran == CoreData.list[1]) {
                  setState(() {
                    filterKehadiran = CoreData.list[2];
                  });
                } else if (filterKehadiran == CoreData.list[2]) {
                  setState(() {
                    filterKehadiran = CoreData.list[3];
                  });
                } else {
                  setState(() {
                    filterKehadiran = 'all';
                  });
                }
              },
              icon: Image.asset(
                MyStrings.filterIconColor,
                scale: 3,
              ),
              label: Text(filterKehadiranTitle),
            ),
          ],
        )
      ],
    );
  }

  Widget _absenList(List<AbsenModel> allAbsen) {
    print('object: $allAbsen');
    if (allAbsen.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            MyStrings.content,
            scale: 2,
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
      return AbsenList(allAbsen: allAbsen);
    }
  }
}
