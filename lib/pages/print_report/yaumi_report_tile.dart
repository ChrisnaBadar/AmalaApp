import 'package:flutter/material.dart';

class YaumiReportTile extends StatelessWidget {
  const YaumiReportTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.description,
                color: Colors.green[700],
              ),
            ],
          ),
          title: Text(
            'Laporan Yaumi Mei 2023',
            style: TextStyle(
                color: Colors.blueGrey[500], fontWeight: FontWeight.bold),
          ),
          subtitle: Text('Tanggal: 11 April 2023 - 10 Mei 2023',
              style: TextStyle(color: Colors.blueGrey[400], fontSize: 12.0)),
          trailing: const Icon(
            Icons.share,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
