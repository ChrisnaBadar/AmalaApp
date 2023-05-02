import 'package:flutter/material.dart';
import 'package:amala/blocs/bloc_exports.dart';

import '../../constants/my_strings.dart';

class YaumiSettings extends StatelessWidget {
  const YaumiSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/homepage');
        return true;
      },
      child: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, settingsState) {},
        builder: (context, settingsState) {
          List<Function(bool)> yaumiSettingsEvents = [
            (val) => context.read<SettingsBloc>().add(TooggleFardhuEvent()),
            (val) => context.read<SettingsBloc>().add(TooggleTahajudEvent()),
            (val) => context.read<SettingsBloc>().add(TooggleRawatibEvent()),
            (val) => context.read<SettingsBloc>().add(TooggleDhuhaEvent()),
            (val) => context.read<SettingsBloc>().add(TooggleTilawahEvent()),
            (val) => context.read<SettingsBloc>().add(TooggleShaumEvent()),
            (val) => context.read<SettingsBloc>().add(TooggleSedekahEvent()),
            (val) => context.read<SettingsBloc>().add(TooggleDzikirEvent()),
            (val) => context.read<SettingsBloc>().add(TooggleTaklimEvent()),
            (val) => context.read<SettingsBloc>().add(TooggleIstighfarEvent()),
            (val) => context.read<SettingsBloc>().add(TooggleShalawatEvent()),
          ];
          List<bool> yaumiSettingsStates = [
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
            settingsState.shalawat,
          ];
          List<String> yaumiSettingsTitles = [
            'Shalat Fardhu?',
            'Shalat Tahajud?',
            'Shalat Rawatib?',
            'Shalat Dhuha?',
            'Tilawah?',
            'Shaum?',
            'Sedekah?',
            'Dzikir?',
            'Taklim?',
            'Istighfar?',
            'Shalawat?'
          ];
          List myImageIcon = [
            MyStrings.fardhuIconColor,
            MyStrings.tahajudIconColor,
            MyStrings.dhuhaIconColor,
            MyStrings.rawatibIconColor,
            MyStrings.tilawahIconColor,
            MyStrings.shaumIconColor,
            MyStrings.sedekahIconColor,
            MyStrings.dzikirIconColor,
            MyStrings.taklimIconColor,
            MyStrings.istighfarIconColor,
            MyStrings.shalawatIconColor,
            MyStrings.absenIconColor
          ];
          return Scaffold(
            appBar: AppBar(
              title: const Text('Settings'),
            ),
            body: Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  //absenSettings
                  Text(
                    'Absen Online',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[700]),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Aktifkan fitur absen online untuk keperluan lembaga atau sekolah',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Colors.blueGrey, fontSize: 11.0),
                      )),
                  ListTile(
                    title: const Text('Aktifkan Fitur Absen Online?'),
                    trailing: Switch(
                        value: settingsState.absen,
                        onChanged: (val) {
                          context.read<SettingsBloc>().add(TooggleAbsenEvent());
                        }),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),

                  //YaumiSettings
                  Text(
                    'Yaumi',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[700]),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Untuk memulai tracking habit ibadah harian silahkan mengaktifkan ibadah apa yang ingin diperbaiki dan dijadikan kebiasaan baik.',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Colors.blueGrey, fontSize: 11.0),
                      )),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 11,
                      itemBuilder: (context, index) {
                        bool switchValue = yaumiSettingsStates[index];
                        Function(bool) onChanged = yaumiSettingsEvents[index];

                        return ListTile(
                          leading: Image.asset(myImageIcon[index], scale: 2),
                          title: Text(yaumiSettingsTitles[index]),
                          trailing: Switch(
                            value: switchValue,
                            onChanged: onChanged,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
