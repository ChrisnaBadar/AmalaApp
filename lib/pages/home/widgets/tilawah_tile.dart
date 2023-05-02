// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:amala/models/yaumi_model.dart';

import '../../../blocs/bloc_exports.dart';

class TilawahTile extends StatefulWidget {
  final YaumiModel todayYaumi;
  final YaumiState yaumiState;
  final SelectedDateState selectedDateState;
  const TilawahTile({
    Key? key,
    required this.todayYaumi,
    required this.yaumiState,
    required this.selectedDateState,
  }) : super(key: key);

  @override
  State<TilawahTile> createState() => _TilawahTileState();
}

class _TilawahTileState extends State<TilawahTile> {
  @override
  Widget build(BuildContext context) {
    final selectedDate = widget.selectedDateState.selectedDate;
    final yaumi = widget.yaumiState.allYaumis;
    var selectedYaumi = yaumi.where((e) => e.date == selectedDate).toList();
    var todayYaumi = selectedYaumi.first;
    return ListTile(
      title: const Text('Tilawah Qur\'an'),
      subtitle: const Text('Per Halaman Qur\'an'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {
                setState(() => context.read<YaumiBloc>().add(
                    UpdateDecrementTilawahEvent(
                        yaumi: todayYaumi, poinHariIni: 1.0)));
              },
              icon: CircleAvatar(
                  backgroundColor:
                      todayYaumi.isSubmitted! ? Colors.green : Colors.blue,
                  child: const Icon(Icons.remove))),
          Text('${widget.todayYaumi.tilawah}'),
          IconButton(
              onPressed: () {
                setState(() => context.read<YaumiBloc>().add(
                    UpdateIncrementTilawahEvent(
                        yaumi: todayYaumi, poinHariIni: 1.0)));
              },
              icon: CircleAvatar(
                  backgroundColor:
                      todayYaumi.isSubmitted! ? Colors.green : Colors.blue,
                  child: const Icon(Icons.add))),
        ],
      ),
    );
  }
}
