// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:amala/models/yaumi_model.dart';

import '../../blocs/bloc_exports.dart';

class LogYaumiList extends StatelessWidget {
  final List<YaumiModel> allYaumis;
  const LogYaumiList({
    Key? key,
    required this.allYaumis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settingsState) {
        final activatedYaumi = [
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
        ].where((e) => e == true).length;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: allYaumis.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${allYaumis[index].poinHariIni}%',
                      style: TextStyle(
                          color: allYaumis[index].poinHariIni! > 79.99
                              ? Colors.green
                              : allYaumis[index].poinHariIni! > 49.99
                                  ? Colors.orange
                                  : Colors.red,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                title: Text(allYaumis[index].id),
                subtitle: Text('dari $activatedYaumi kategori yaumi aktif'),
              ),
            );
          },
        );
      },
    );
  }
}
