// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:amala/pages/absen/widgets/absen_tile.dart';

import '../../../models/absen_model.dart';

class AbsenList extends StatelessWidget {
  final List<AbsenModel> allAbsen;
  const AbsenList({
    Key? key,
    required this.allAbsen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: allAbsen.length,
      itemBuilder: (context, index) {
        return AbsenTile(absenModel: allAbsen[index]);
      },
    );
  }
}
