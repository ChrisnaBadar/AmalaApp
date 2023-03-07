import 'package:flutter/material.dart';

import '../../models/hive/hive_absen_model.dart';
import 'absen_tile.dart';
import 'controllers/absen_controller.dart';

class AbsenList extends StatefulWidget {
  final List<HiveAbsenModel>? hiveAbsenModel;
  final AbsenController? absenController;
  const AbsenList({super.key, this.hiveAbsenModel, this.absenController});

  @override
  State<AbsenList> createState() => _AbsenListState();
}

class _AbsenListState extends State<AbsenList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.hiveAbsenModel!.length,
      itemBuilder: (context, index) => AbsenTile(
        hiveAbsenModel: widget.hiveAbsenModel![index],
        absenController: widget.absenController,
      ),
    );
  }
}
