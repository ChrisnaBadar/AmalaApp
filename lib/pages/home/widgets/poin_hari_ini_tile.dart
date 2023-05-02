// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amala/constants/my_strings.dart';
import 'package:flutter/material.dart';

import 'package:amala/blocs/bloc_exports.dart';
import 'package:amala/models/yaumi_model.dart';

class PoinHariIniTile extends StatelessWidget {
  final SettingsState settingsState;
  final YaumiModel todayYaumi;
  const PoinHariIniTile({
    Key? key,
    required this.settingsState,
    required this.todayYaumi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    var myPoin = (todayYaumi.poinHariIni! / activatedYaumi) * 100;
    return activatedYaumi == 0
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                MyStrings.content,
                scale: 3,
              ),
              Text(
                'Aktifkan Yaumi pilihan anda di settings / pengaturan.',
                style: TextStyle(color: Colors.blueGrey[500]),
              )
            ],
          )
        : Text('Pencapaian Yaumi: ${myPoin.roundToDouble()}%');
  }
}
