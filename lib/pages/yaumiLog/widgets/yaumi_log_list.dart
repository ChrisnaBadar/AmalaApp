import 'package:amala/pages/yaumiLog/widgets/yaumi_log_tile.dart';
import 'package:flutter/material.dart';

import '../../../models/hive/hive_yaumi_active_model.dart';
import '../../../models/hive/hive_yaumi_model.dart';
import '../controller/yaumi_log_controller.dart';

class YaumiLogList extends StatelessWidget {
  final List<HiveYaumiModel>? hiveYaumiModel;
  final List<HiveYaumiActiveModel>? hiveYaumiActiveModel;
  final List? tanggal;
  final YaumiLogController? yaumiLogController;
  const YaumiLogList(
      {super.key,
      this.hiveYaumiModel,
      this.hiveYaumiActiveModel,
      this.yaumiLogController,
      this.tanggal});

  @override
  Widget build(BuildContext context) {
    final myList = hiveYaumiModel!
      ..sort((item1, item2) => item2.tanggal!.compareTo(item1.tanggal!));
    return ListView.builder(
      itemCount: myList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => YaumiLogTile(
        hiveYaumiModel: myList[index],
        hiveYaumiActiveModel: hiveYaumiActiveModel!.first,
        yaumiLogController: yaumiLogController,
        hiveYaumiActiveModelList: hiveYaumiActiveModel!,
        tanggalList: tanggal!,
      ),
    );
  }
}
