import 'package:amala/constants/my_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../models/hive/hive_absen_model.dart';
import 'controllers/absen_controller.dart';

class AbsenTile extends StatefulWidget {
  final HiveAbsenModel? hiveAbsenModel;
  final AbsenController? absenController;
  const AbsenTile({super.key, this.hiveAbsenModel, this.absenController});

  @override
  State<AbsenTile> createState() => _AbsenTileState();
}

class _AbsenTileState extends State<AbsenTile> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
        key: const ValueKey(0),
        startActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              widget.absenController!.deleteData(widget.hiveAbsenModel!.date!);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (context) {
              _bottomSheet(context);
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: 'Share',
          )
        ]),
        child: Card(
          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.hiveAbsenModel!.kehadiran ==
                        '*Work Form Office / Field* (WFO)'
                    ? const Text('WFO',
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 20.0))
                    : widget.hiveAbsenModel!.kehadiran ==
                            '*Work From Home* (WFH)'
                        ? const Text('WFH',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 20.0))
                        : widget.hiveAbsenModel!.kehadiran == '*Sakit*'
                            ? Image.asset(
                                MyStrings.feverIconColor,
                                scale: 2,
                              )
                            : Image.asset(
                                MyStrings.leaveIconColor,
                                scale: 2,
                              ),
              ],
            ),
            title: Text(widget.hiveAbsenModel!.tanggal!),
            subtitle: Text(widget.hiveAbsenModel!.kehadiran!),
          ),
        ));
  }

  _bottomSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      context: context,
      builder: (context) {
        return SizedBox(
          height: 150.0,
          child: Column(
            children: [
              const SizedBox(
                height: 8.0,
              ),
              Container(
                width: 100.0,
                height: 5.0,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.blueGrey),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(widget.hiveAbsenModel!.tanggal!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  )),
              const SizedBox(
                height: 8.0,
              ),
              Text(widget.hiveAbsenModel!.kehadiran!,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  )),
              const SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {},
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: const Text('Share'),
                    )),
              )
            ],
          ),
        );
      },
    );
  }
}
