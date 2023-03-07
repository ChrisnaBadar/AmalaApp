import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../form/absen_form.dart';
import '../model/absen_model.dart';

class AbsenFlexibleAppbar extends StatefulWidget {
  final String? uid;
  final String? uidGroup;
  final String? nama;
  final String? tanggal;
  final String? waktu;
  final String? lokasi;
  const AbsenFlexibleAppbar(
      {super.key,
      this.uid,
      this.uidGroup,
      this.nama,
      this.tanggal,
      this.waktu,
      this.lokasi});

  @override
  State<AbsenFlexibleAppbar> createState() => _AbsenFlexibleAppbarState();
}

class _AbsenFlexibleAppbarState extends State<AbsenFlexibleAppbar> {
  @override
  Widget build(BuildContext context) {
    final absen = Provider.of<List<AbsenModel>>(context);

    if (absen.isNotEmpty) {
      var myAbsen =
          absen.where((element) => element.uid == widget.uid).toList();
      var tanggalSekarang = DateFormat("dd MMMM yyyy").format(DateTime.now());
      var todayAbsen = myAbsen.where((element) =>
          DateFormat("dd MMMM yyyy").format(DateTime.parse(element.tanggal!)) ==
          tanggalSekarang);

      return Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  'Absen Online',
                  style: TextStyle(
                      fontSize: 32.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
              ),
              todayAbsen.isEmpty
                  ? Container(
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[900],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: IconButton(
                          iconSize: 24,
                          onPressed: () {
                            Get.to(() => const AbsenForm(), arguments: {
                              'absenDone': false,
                              'uid': widget.uid,
                              'uidGroup': widget.uidGroup,
                              'nama': widget.nama,
                              'tanggal': widget.tanggal,
                              'waktu': widget.waktu,
                              'lokasi': widget.lokasi
                            });
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: IconButton(
                          iconSize: 24,
                          onPressed: () {
                            Get.to(() => const AbsenForm(), arguments: {
                              'absenDone': true,
                              'uid': widget.uid,
                              'uidGroup': widget.uidGroup,
                              'nama': widget.nama,
                              'tanggal': widget.tanggal,
                              'waktu': widget.waktu,
                              'lokasi': widget.lokasi
                            });
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
            ],
          ));
    } else {
      return Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  'Absen Online',
                  style: TextStyle(
                      fontSize: 32.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: IconButton(
                    iconSize: 24,
                    onPressed: () {
                      Get.to(() => const AbsenForm(), arguments: {
                        'absenDone': false,
                        'uid': widget.uid,
                        'uidGroup': widget.uidGroup,
                        'nama': widget.nama,
                        'tanggal': widget.tanggal,
                        'waktu': widget.waktu,
                        'lokasi': widget.lokasi
                      });
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ));
    }
  }
}
