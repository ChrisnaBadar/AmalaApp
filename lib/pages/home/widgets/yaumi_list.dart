import 'package:amala/constants/my_strings.dart';
import 'package:amala/models/yaumi_model.dart';
import 'package:amala/pages/home/widgets/poin_hari_ini_tile.dart';
import 'package:amala/pages/home/widgets/tilawah_tile.dart';
import 'package:amala/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import '../../../blocs/bloc_exports.dart';

class YaumiList extends StatefulWidget {
  const YaumiList({
    Key? key,
  }) : super(key: key);

  @override
  State<YaumiList> createState() => _YaumiListState();
}

class _YaumiListState extends State<YaumiList> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (userContext, userState) {
        return BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, settingsState) {
            return BlocBuilder<SelectedDateBloc, SelectedDateState>(
              builder: (context, selectedDateState) {
                final selectedDate = selectedDateState.selectedDate;
                return BlocBuilder<YaumiBloc, YaumiState>(
                  builder: (context, yaumiState) {
                    final yaumi = yaumiState.allYaumis;
                    var selectedYaumi =
                        yaumi.where((e) => e.date == selectedDate).toList();
                    if (selectedYaumi.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                MyStrings.reportIconColor,
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                'Isi Yaumi ${DateFormat('EEEE, dd MMM yyyy', "ID_id").format(selectedDate)}?',
                                style: TextStyle(
                                    fontFamily: 'Raleway',
                                    color: Colors.indigo[800],
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    context.read<YaumiBloc>().add(AddYaumiEvent(
                                        yaumi: YaumiModel(
                                            id: selectedDate.toString(),
                                            date: selectedDate,
                                            nama: userState.nama)));
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width,
                                      child: const Text(
                                        'ISI YAUMI',
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.bold),
                                      ))),
                            ]),
                      );
                    } else {
                      var todayYaumi = selectedYaumi.first;
                      return loading
                          ? const Center(
                              child: SpinKitDancingSquare(color: Colors.amber),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(' Jumlah Model: ${yaumi.length}',
                                            style: const TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.blueGrey)),
                                        TextButton(
                                            onPressed: () {
                                              context.read<YaumiBloc>().add(
                                                  DeleteYaumiEvent(
                                                      yaumi: todayYaumi));
                                            },
                                            child: const Text('Hapus')),
                                      ],
                                    ),
                                  ),
                                  settingsState.fardhu
                                      ? ListTile(
                                          title: const Text('Shalat Shubuh'),
                                          subtitle: const Text(
                                              'Sub Title Shalat Fardhu'),
                                          trailing: Checkbox(
                                              activeColor: _submitColor(
                                                  todayYaumi.isSubmitted!),
                                              value: todayYaumi.shubuh,
                                              onChanged: (val) {
                                                context.read<YaumiBloc>().add(
                                                    UpdateShubuhEvent(
                                                        yaumi: todayYaumi,
                                                        poinHariIni: 1.0));
                                              }),
                                          onTap: () {
                                            context.read<YaumiBloc>().add(
                                                UpdateShubuhEvent(
                                                    yaumi: todayYaumi,
                                                    poinHariIni: 1.0));
                                          })
                                      : Container(),
                                  settingsState.fardhu
                                      ? ListTile(
                                          title: const Text('Shalat Dhuhur'),
                                          subtitle: const Text(
                                              'Sub Title Shalat Dhuhur'),
                                          trailing: Checkbox(
                                              activeColor: _submitColor(
                                                  todayYaumi.isSubmitted!),
                                              value: todayYaumi.dhuhur,
                                              onChanged: (val) {
                                                context.read<YaumiBloc>().add(
                                                    UpdateDhuhurEvent(
                                                        yaumi: todayYaumi,
                                                        poinHariIni: 1.0));
                                              }),
                                          onTap: () {
                                            context.read<YaumiBloc>().add(
                                                UpdateDhuhurEvent(
                                                    yaumi: todayYaumi,
                                                    poinHariIni: 1.0));
                                          },
                                        )
                                      : Container(),
                                  settingsState.fardhu
                                      ? ListTile(
                                          title: const Text('Shalat Ashar'),
                                          subtitle: const Text('Poin Yaumi'),
                                          trailing: Checkbox(
                                              activeColor: _submitColor(
                                                  todayYaumi.isSubmitted!),
                                              value: todayYaumi.ashar,
                                              onChanged: (val) {
                                                context.read<YaumiBloc>().add(
                                                    UpdateAsharEvent(
                                                        yaumi: todayYaumi,
                                                        poinHariIni: 1.0));
                                              }),
                                          onTap: () {
                                            context.read<YaumiBloc>().add(
                                                UpdateAsharEvent(
                                                    yaumi: todayYaumi,
                                                    poinHariIni: 1.0));
                                          },
                                        )
                                      : Container(),
                                  settingsState.fardhu
                                      ? ListTile(
                                          title: const Text('Shalat Maghrib'),
                                          subtitle: const Text('Poin Yaumi'),
                                          trailing: Checkbox(
                                              activeColor: _submitColor(
                                                  todayYaumi.isSubmitted!),
                                              value: todayYaumi.maghrib,
                                              onChanged: (val) {
                                                context.read<YaumiBloc>().add(
                                                    UpdateMaghribEvent(
                                                        yaumi: todayYaumi,
                                                        poinHariIni: 1.0));
                                              }),
                                          onTap: () {
                                            context.read<YaumiBloc>().add(
                                                UpdateMaghribEvent(
                                                    yaumi: todayYaumi,
                                                    poinHariIni: 1.0));
                                          },
                                        )
                                      : Container(),
                                  settingsState.fardhu
                                      ? ListTile(
                                          title: const Text('Shalat Isya'),
                                          subtitle: const Text('Poin Yaumi'),
                                          trailing: Checkbox(
                                              activeColor: _submitColor(
                                                  todayYaumi.isSubmitted!),
                                              value: todayYaumi.isya,
                                              onChanged: (val) {
                                                context.read<YaumiBloc>().add(
                                                    UpdateIsyaEvent(
                                                        yaumi: todayYaumi,
                                                        poinHariIni: 1.0));
                                              }),
                                          onTap: () {
                                            context.read<YaumiBloc>().add(
                                                UpdateIsyaEvent(
                                                    yaumi: todayYaumi,
                                                    poinHariIni: 1.0));
                                          },
                                        )
                                      : Container(),
                                  settingsState.tahajud
                                      ? ListTile(
                                          title: const Text('Shalat Tahajud'),
                                          subtitle: const Text('Poin Yaumi'),
                                          trailing: Checkbox(
                                              activeColor: _submitColor(
                                                  todayYaumi.isSubmitted!),
                                              value: todayYaumi.tahajud,
                                              onChanged: (val) {
                                                context.read<YaumiBloc>().add(
                                                    UpdateTahajudEvent(
                                                        yaumi: todayYaumi,
                                                        poinHariIni: 1.0));
                                              }),
                                          onTap: () {
                                            context.read<YaumiBloc>().add(
                                                UpdateTahajudEvent(
                                                    yaumi: todayYaumi,
                                                    poinHariIni: 1.0));
                                          },
                                        )
                                      : Container(),
                                  settingsState.rawatib
                                      ? ListTile(
                                          title: const Text('Shalat Rawatib'),
                                          subtitle: const Text('Poin Yaumi'),
                                          trailing: Checkbox(
                                              activeColor: _submitColor(
                                                  todayYaumi.isSubmitted!),
                                              value: todayYaumi.rawatib,
                                              onChanged: (val) {
                                                context.read<YaumiBloc>().add(
                                                    UpdateRawatibEvent(
                                                        yaumi: todayYaumi,
                                                        poinHariIni: 1.0));
                                              }),
                                          onTap: () {
                                            context.read<YaumiBloc>().add(
                                                UpdateRawatibEvent(
                                                    yaumi: todayYaumi,
                                                    poinHariIni: 1.0));
                                          },
                                        )
                                      : Container(),
                                  settingsState.dhuha
                                      ? ListTile(
                                          title: const Text('Shalat Dhuha'),
                                          subtitle: const Text('Poin Yaumi'),
                                          trailing: Checkbox(
                                              activeColor: _submitColor(
                                                  todayYaumi.isSubmitted!),
                                              value: todayYaumi.dhuha,
                                              onChanged: (val) {
                                                context.read<YaumiBloc>().add(
                                                    UpdateDhuhaEvent(
                                                        yaumi: todayYaumi,
                                                        poinHariIni: 1.0));
                                              }),
                                          onTap: () {
                                            context.read<YaumiBloc>().add(
                                                UpdateDhuhaEvent(
                                                    yaumi: todayYaumi,
                                                    poinHariIni: 1.0));
                                          },
                                        )
                                      : Container(),
                                  settingsState.tilawah
                                      ? TilawahTile(
                                          todayYaumi: todayYaumi,
                                          selectedDateState: selectedDateState,
                                          yaumiState: yaumiState,
                                        )
                                      : Container(),
                                  settingsState.shaum
                                      ? ListTile(
                                          title: const Text('Shaum Sunnah'),
                                          subtitle: const Text('Poin Yaumi'),
                                          trailing: Checkbox(
                                              activeColor: _submitColor(
                                                  todayYaumi.isSubmitted!),
                                              value: todayYaumi.shaum,
                                              onChanged: (val) {
                                                context.read<YaumiBloc>().add(
                                                    UpdateShaumEvent(
                                                        yaumi: todayYaumi,
                                                        poinHariIni: 1.0));
                                              }),
                                          onTap: () {
                                            context.read<YaumiBloc>().add(
                                                UpdateShaumEvent(
                                                    yaumi: todayYaumi,
                                                    poinHariIni: 1.0));
                                          },
                                        )
                                      : Container(),
                                  settingsState.sedekah
                                      ? ListTile(
                                          title: const Text('Sedekah Harian'),
                                          subtitle: const Text('Poin Yaumi'),
                                          trailing: Checkbox(
                                              activeColor: _submitColor(
                                                  todayYaumi.isSubmitted!),
                                              value: todayYaumi.sedekah,
                                              onChanged: (val) {
                                                context.read<YaumiBloc>().add(
                                                    UpdateSedekahEvent(
                                                        yaumi: todayYaumi,
                                                        poinHariIni: 1.0));
                                              }),
                                          onTap: () {
                                            context.read<YaumiBloc>().add(
                                                UpdateSedekahEvent(
                                                    yaumi: todayYaumi,
                                                    poinHariIni: 1.0));
                                          },
                                        )
                                      : Container(),
                                  settingsState.dzikir
                                      ? ListTile(
                                          title: const Text('Dzikir Pagi'),
                                          subtitle: const Text('Poin Yaumi'),
                                          trailing: Checkbox(
                                              activeColor: _submitColor(
                                                  todayYaumi.isSubmitted!),
                                              value: todayYaumi.dzikirPagi,
                                              onChanged: (val) {
                                                context.read<YaumiBloc>().add(
                                                    UpdateDzikirPagiEvent(
                                                        yaumi: todayYaumi,
                                                        poinHariIni: 1.0));
                                              }),
                                          onTap: () {
                                            context.read<YaumiBloc>().add(
                                                UpdateDzikirPagiEvent(
                                                    yaumi: todayYaumi,
                                                    poinHariIni: 1.0));
                                          },
                                        )
                                      : Container(),
                                  settingsState.dzikir
                                      ? ListTile(
                                          title: const Text('Dzikir Petang'),
                                          subtitle: const Text('Poin Yaumi'),
                                          trailing: Checkbox(
                                              activeColor: _submitColor(
                                                  todayYaumi.isSubmitted!),
                                              value: todayYaumi.dzikirPetang,
                                              onChanged: (val) {
                                                context.read<YaumiBloc>().add(
                                                    UpdateDzikirPetangEvent(
                                                        yaumi: todayYaumi,
                                                        poinHariIni: 1.0));
                                              }),
                                          onTap: () {
                                            context.read<YaumiBloc>().add(
                                                UpdateDzikirPetangEvent(
                                                    yaumi: todayYaumi,
                                                    poinHariIni: 1.0));
                                          },
                                        )
                                      : Container(),
                                  settingsState.taklim
                                      ? ListTile(
                                          title: const Text('Taklim'),
                                          subtitle: const Text('Poin Yaumi'),
                                          trailing: Checkbox(
                                              activeColor: _submitColor(
                                                  todayYaumi.isSubmitted!),
                                              value: todayYaumi.taklim,
                                              onChanged: (val) {
                                                context.read<YaumiBloc>().add(
                                                    UpdateTaklimEvent(
                                                        yaumi: todayYaumi,
                                                        poinHariIni: 1.0));
                                              }),
                                          onTap: () {
                                            context.read<YaumiBloc>().add(
                                                UpdateTaklimEvent(
                                                    yaumi: todayYaumi,
                                                    poinHariIni: 1.0));
                                          },
                                        )
                                      : Container(),
                                  settingsState.istighfar
                                      ? ListTile(
                                          title: const Text('Istighfar'),
                                          subtitle: const Text('Poin Yaumi'),
                                          trailing: Checkbox(
                                              activeColor: _submitColor(
                                                  todayYaumi.isSubmitted!),
                                              value: todayYaumi.istighfar,
                                              onChanged: (val) {
                                                context.read<YaumiBloc>().add(
                                                    UpdateIstighfarEvent(
                                                        yaumi: todayYaumi,
                                                        poinHariIni: 1.0));
                                              }),
                                          onTap: () {
                                            context.read<YaumiBloc>().add(
                                                UpdateIstighfarEvent(
                                                    yaumi: todayYaumi,
                                                    poinHariIni: 1.0));
                                          },
                                        )
                                      : Container(),
                                  settingsState.shalawat
                                      ? ListTile(
                                          title: const Text('Shalawat'),
                                          subtitle: const Text('Poin Yaumi'),
                                          trailing: Checkbox(
                                              activeColor: _submitColor(
                                                  todayYaumi.isSubmitted!),
                                              value: todayYaumi.shalawat,
                                              onChanged: (val) {
                                                context.read<YaumiBloc>().add(
                                                    UpdateShalawatEvent(
                                                        yaumi: todayYaumi,
                                                        poinHariIni: 1.0));
                                              }),
                                          onTap: () {
                                            context.read<YaumiBloc>().add(
                                                UpdateShalawatEvent(
                                                    yaumi: todayYaumi,
                                                    poinHariIni: 1.0));
                                          },
                                        )
                                      : Container(),
                                  PoinHariIniTile(
                                    settingsState: settingsState,
                                    todayYaumi: todayYaumi,
                                  ),
                                  [
                                    settingsState.fardhu,
                                    settingsState.tahajud,
                                    settingsState.rawatib,
                                    settingsState.dhuha,
                                    settingsState.tilawah,
                                    settingsState.shaum,
                                    settingsState.sedekah,
                                    settingsState.dzikir,
                                    settingsState.taklim,
                                    settingsState.istighfar,
                                    settingsState.shalawat
                                  ].contains(true)
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor: todayYaumi
                                                          .isSubmitted!
                                                      ? MaterialStateProperty
                                                          .all(Colors.green)
                                                      : MaterialStateProperty
                                                          .all(Colors.blue)),
                                              onPressed: () async {
                                                Future.delayed(
                                                    Duration.zero,
                                                    () => showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              _alertDialog(
                                                                  context,
                                                                  todayYaumi,
                                                                  selectedDateState,
                                                                  settingsState),
                                                        ));
                                              },
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: todayYaumi.isSubmitted!
                                                      ? const Text(
                                                          'UPDATE',
                                                          textAlign:
                                                              TextAlign.center,
                                                        )
                                                      : const Text(
                                                          'SUBMIT',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ))),
                                        )
                                      : Container()
                                ],
                              ),
                            );
                    }
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Future _createYaumiData(
      String id, DateTime selectedDate, String name, int modelNumbers) async {
    Future.delayed(
        Duration.zero,
        () => context.read<YaumiBloc>().add(AddYaumiEvent(
            yaumi: YaumiModel(id: id, date: selectedDate, nama: name))));
    if (modelNumbers == (modelNumbers + 1)) {
      return;
    } else {
      context.read<YaumiBloc>().add(DeleteYaumiEvent(
          yaumi: YaumiModel(id: id, date: selectedDate, nama: name)));
    }
  }

  Color _submitColor(bool isSubmitted) {
    return isSubmitted ? Colors.green : Colors.blue;
  }

  _alertDialog(BuildContext context, YaumiModel todayYaumi,
      SelectedDateState selectedDateState, SettingsState settingsState) {
    final activatedYaumi = [
      settingsState.fardhu,
      settingsState.fardhu,
      settingsState.fardhu,
      settingsState.fardhu,
      settingsState.fardhu,
      settingsState.tahajud,
      settingsState.rawatib,
      settingsState.dhuha,
      settingsState.tilawah,
      settingsState.tilawah,
      settingsState.tilawah,
      settingsState.tilawah,
      settingsState.tilawah,
      settingsState.tilawah,
      settingsState.tilawah,
      settingsState.tilawah,
      settingsState.tilawah,
      settingsState.tilawah,
      settingsState.shaum,
      settingsState.sedekah,
      settingsState.dzikir,
      settingsState.dzikir,
      settingsState.taklim,
      settingsState.istighfar,
      settingsState.shalawat
    ].where((e) => e == true).length;
    List yaumiList = [
      todayYaumi.shubuh,
      todayYaumi.dhuhur,
      todayYaumi.ashar,
      todayYaumi.maghrib,
      todayYaumi.isya,
      todayYaumi.tahajud,
      todayYaumi.dhuha,
      todayYaumi.rawatib,
      todayYaumi.tilawah,
      todayYaumi.shaum,
      todayYaumi.sedekah,
      todayYaumi.dzikirPagi,
      todayYaumi.dzikirPetang,
      todayYaumi.taklim,
      todayYaumi.istighfar,
      todayYaumi.shalawat
    ];
    final poin = (todayYaumi.poinHariIni! / activatedYaumi) * 100;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return AlertDialog(
          content: Text.rich(TextSpan(children: [
            const TextSpan(text: 'Submit data Yaumi tanggal '),
            TextSpan(
                text: '${selectedDateState.selectedDate} ',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: 'dengan nilai poin: ${poin.roundToDouble()}%?')
          ])),
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    loading = true;
                  });
                  try {
                    DatabaseService(uid: state.uid).setDataYaumi(
                        todayYaumi.date,
                        yaumiList,
                        true,
                        poin.roundToDouble(),
                        state.nama);
                    context
                        .read<YaumiBloc>()
                        .add(UploadedStateDataEvent(yaumi: todayYaumi));
                    setState(() {
                      loading = false;
                    });
                    Navigator.pop(context);
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text('Yes')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'))
          ],
        );
      },
    );
  }
}
