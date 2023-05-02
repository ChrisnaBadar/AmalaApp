import 'package:flutter/material.dart';

class DateLocationHeader extends StatelessWidget {
  final String? hari;
  final String? tanggal;
  final String? wilayah;
  final String? kota;
  const DateLocationHeader(
      {super.key, this.hari, this.tanggal, this.wilayah, this.kota});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.calendar_month,
                  color: Colors.blue,
                ),
                Expanded(
                  child: Text.rich(
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12.0),
                    TextSpan(children: [
                      TextSpan(
                          text: ' $hari, ',
                          style: TextStyle(color: Colors.amber[900])),
                      TextSpan(
                          text: '$tanggal',
                          style: TextStyle(color: Colors.blueGrey[900])),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text.rich(
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 12.0),
                    TextSpan(children: [
                      TextSpan(
                          text: '$wilayah, ',
                          style: TextStyle(color: Colors.blueGrey[900])),
                      TextSpan(
                          text: '$kota ',
                          style: TextStyle(color: Colors.amber[900])),
                    ]),
                  ),
                ),
                const Icon(
                  Icons.pin_drop,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
