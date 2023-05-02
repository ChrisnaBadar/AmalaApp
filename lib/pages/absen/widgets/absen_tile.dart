// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amala/constants/core_data.dart';
import 'package:amala/services/database_service.dart';
import 'package:flutter/material.dart';

import 'package:amala/models/absen_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../../blocs/bloc_exports.dart';
import '../../../constants/my_strings.dart';

class AbsenTile extends StatefulWidget {
  final AbsenModel absenModel;
  const AbsenTile({
    Key? key,
    required this.absenModel,
  }) : super(key: key);

  @override
  State<AbsenTile> createState() => _AbsenTileState();
}

class _AbsenTileState extends State<AbsenTile> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Card(
            child: ListTile(
          leading: _leading(),
          title: _title(),
          subtitle: _subtitile(),
          trailing: _trailing(),
          onTap: () => showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(10.0))),
            builder: (context) =>
                _bottomSheet(context, widget.absenModel, state.uid, state.nama),
          ),
        ));
      },
    );
  }

  _leading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.absenModel.kehadiran == CoreData.list[0]
            ? const Text(
                'WFO',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              )
            : widget.absenModel.kehadiran == CoreData.list[1]
                ? Image.asset(
                    MyStrings.leaveIconColor,
                    scale: 2,
                  )
                : widget.absenModel.kehadiran == CoreData.list[2]
                    ? Image.asset(
                        MyStrings.feverIconColor,
                        scale: 2,
                      )
                    : const Text(
                        'WFO',
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      )
      ],
    );
  }

  _title() {
    return Text(widget.absenModel.kehadiran);
  }

  _subtitile() {
    return Text(widget.absenModel.tanggal);
  }

  _trailing() {
    return const Icon(Icons.view_list_rounded);
  }

  _bottomSheet(context, AbsenModel absenModel, String uid, String nama) {
    var sharedText =
        '*${DateFormat('EEEE, dd MMMM yyyy', "id_ID").format(absenModel.date)}*\nNama: *$nama*\nKehadiran: ${absenModel.kehadiran}\nWaktu: ${absenModel.waktu}\nLokasi: ${absenModel.lokasi}';
    return BlocBuilder<AbsenBloc, AbsenState>(
      builder: (absenContext, state) {
        return SizedBox(
          height: 175.0,
          child: loading
              ? const Center(
                  child: SpinKitDancingSquare(color: Colors.amber),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      width: 75.0,
                      height: 5.0,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.blueGrey,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      absenModel.kehadiran,
                      style: const TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 17.5),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      absenModel.tanggal,
                      style: const TextStyle(
                          fontSize: 15.0, color: Colors.blueGrey),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .4,
                            child: ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    loading = true;
                                  });
                                  try {
                                    DatabaseService(uid: uid).deleteDataAbsen(
                                        DateFormat('ddMMMyy')
                                            .format(absenModel.date));
                                    absenContext.read<AbsenBloc>().add(
                                        DeleteAbsenEvent(absen: absenModel));
                                    setState(() {
                                      loading = false;
                                    });
                                    Navigator.pop(context);
                                  } catch (e) {
                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                },
                                icon: Image.asset(
                                  MyStrings.deleteIconColor,
                                  scale: 3,
                                ),
                                label: const Text('Delete'))),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .4,
                            child: ElevatedButton.icon(
                                onPressed: () async {
                                  await Share.share(sharedText);
                                },
                                icon: const Icon(
                                  Icons.share_outlined,
                                  color: Colors.white,
                                ),
                                label: const Text('Share'))),
                      ],
                    )
                  ],
                ),
        );
      },
    );
  }
}
