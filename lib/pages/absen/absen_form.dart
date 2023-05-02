import 'package:amala/blocs/bloc_exports.dart';
import 'package:amala/constants/core_data.dart';
import 'package:amala/models/absen_model.dart';
import 'package:amala/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../../constants/my_strings.dart';
import '../../services/database_service.dart';

class AbsenForm extends StatefulWidget {
  const AbsenForm({super.key});

  @override
  State<AbsenForm> createState() => _AbsenFormState();
}

class _AbsenFormState extends State<AbsenForm>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  static List<String> list = <String>[
    'Work From Office / Field (WFO)',
    'Ijin',
    'Sakit',
    'Work From Home (WFH)'
  ];
  var tanggalView = DateFormat('EEEE, dd MMMM yyyy', "id_ID").format(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
  var waktu = DateFormat.jm().format(DateTime.now());
  bool loading = false;
  String dropdownValue = list.first;
  String wilayah = '';

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: CoreData.locationFetchDuration));
    _animationController!.forward();
    LocationService().getLocation().then((value) {
      if (!value) {
        setState(() {
          wilayah = 'Lokasi tidak terbaca';
        });
      } else {
        setState(() {
          wilayah = CoreData.wilayah;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Scaffold(
            body: Center(
              child: SpinKitDancingSquare(
                color: Colors.amber,
              ),
            ),
          )
        : BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                bottomNavigationBar: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: const Text(
                        'SUBMIT',
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        setState(() {
                          loading = true;
                        });
                        try {
                          DatabaseService(uid: state.uid).setDataAbsen(
                              DateTime(DateTime.now().year,
                                  DateTime.now().month, DateTime.now().day),
                              DateFormat.jm().format(DateTime.now()),
                              state.nama,
                              dropdownValue,
                              '-',
                              '-',
                              CoreData.wilayah);
                          context.read<AbsenBloc>().add(AddAbsenEvent(
                              absen: AbsenModel(
                                  date: DateTime(DateTime.now().year,
                                      DateTime.now().month, DateTime.now().day),
                                  tanggal: DateFormat('dd MMMM yyyy', 'id_ID')
                                      .format(DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month,
                                          DateTime.now().day)),
                                  nama: state.nama,
                                  waktu: DateFormat.jm().format(DateTime.now()),
                                  lokasi: CoreData.wilayah,
                                  kehadiran: dropdownValue,
                                  tanggalIjin: '-',
                                  keperluan: '-')));
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
                    )),
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 16.0,
                        ),
                        Row(children: [
                          Container(
                            decoration: const BoxDecoration(
                                color: Colors.black12,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_left_outlined),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 8.0,
                        ),
                        const Text(
                          'Kehadiran Hari Ini',
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: DropdownButtonFormField(
                            value: dropdownValue,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)))),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            onChanged: (String? value) {
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black12, width: 3.0),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tanggalView,
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                //Dropdown??
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      waktu,
                                      style: const TextStyle(fontSize: 12.0),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      MyStrings.locationPinIconColor,
                                      scale: 3,
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    wilayah.isEmpty
                                        ? Countdown(
                                            animation: StepTween(
                                                    begin: CoreData
                                                        .locationFetchDuration,
                                                    end: 0)
                                                .animate(_animationController!),
                                          )
                                        : Text(wilayah),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key? key, this.animation})
      : super(key: key, listenable: animation!);
  final Animation<int>? animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation!.value);

    String timerText =
        clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0');

    return Text(
      "Mencari lokasi ... ($timerText)",
      style: TextStyle(
        fontSize: 11.0,
        color: Colors.blueGrey[700],
      ),
    );
  }
}
