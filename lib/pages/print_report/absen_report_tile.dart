import 'package:amala/services/excelService.dart';
import 'package:flutter/material.dart';

import '../../models/absen_model.dart';

class AbsenReportTile extends StatelessWidget {
  final String prevMonth;
  final String currentMonth;
  final String month;
  final List<AbsenModel> myResult;
  final String namaLembaga;
  final DateTime myDate;
  const AbsenReportTile(
      {super.key,
      required this.prevMonth,
      required this.currentMonth,
      required this.month,
      required this.myResult,
      required this.namaLembaga,
      required this.myDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        child: ListTile(
            title: Text(
              'Absen Online $month',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.blueGrey[500], fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Tanggal: $prevMonth - $currentMonth',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.blueGrey[400], fontSize: 12.0)),
            trailing: ElevatedButton.icon(
              onPressed: () {
                ExcelService().generateAbsenSheet(
                    absenModel: myResult, myDate: myDate, lembaga: namaLembaga);
              },
              label: const Text('Share'),
              icon: const Icon(
                Icons.share,
              ),
            )),
      ),
    );
  }
}
