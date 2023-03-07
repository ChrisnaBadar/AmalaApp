import 'package:amala/pages/yaumiLog/widgets/yaumi_log_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/hive/hive_yaumi_active_model.dart';
import '../../../models/hive/hive_yaumi_model.dart';
import '../controller/yaumi_log_controller.dart';

class YaumiLogTile extends StatelessWidget {
  final HiveYaumiModel? hiveYaumiModel;
  final HiveYaumiActiveModel? hiveYaumiActiveModel;
  final YaumiLogController? yaumiLogController;
  final List<HiveYaumiActiveModel>? hiveYaumiActiveModelList;
  final List? tanggalList;
  const YaumiLogTile(
      {super.key,
      this.hiveYaumiModel,
      this.hiveYaumiActiveModel,
      this.yaumiLogController,
      this.hiveYaumiActiveModelList,
      this.tanggalList});

  @override
  Widget build(BuildContext context) {
    var tanggal = DateFormat('EEEE, dd MMMM yyyy', "id_ID")
        .format(hiveYaumiModel!.tanggal!);
    List hiveYaumiActiveModelList = [
      hiveYaumiActiveModel!.fardhu,
      hiveYaumiActiveModel!.fardhu,
      hiveYaumiActiveModel!.fardhu,
      hiveYaumiActiveModel!.fardhu,
      hiveYaumiActiveModel!.fardhu,
      hiveYaumiActiveModel!.tahajud,
      hiveYaumiActiveModel!.dhuha,
      hiveYaumiActiveModel!.rawatib,
      hiveYaumiActiveModel!.tilawah,
      hiveYaumiActiveModel!.shaum,
      hiveYaumiActiveModel!.sedekah,
      hiveYaumiActiveModel!.dzikir,
      hiveYaumiActiveModel!.dzikir,
      hiveYaumiActiveModel!.taklim,
      hiveYaumiActiveModel!.istighfar,
      hiveYaumiActiveModel!.shalawat,
    ];
    List yaumiModelList = [
      hiveYaumiActiveModel!.fardhu!
          ? (hiveYaumiModel!.shubuh! ? 1 : 0) +
              (hiveYaumiModel!.dhuhur! ? 1 : 0) +
              (hiveYaumiModel!.ashar! ? 1 : 0) +
              (hiveYaumiModel!.maghrib! ? 1 : 0) +
              (hiveYaumiModel!.isya! ? 1 : 0)
          : 0,
      hiveYaumiActiveModel!.tahajud!
          ? hiveYaumiModel!.tahajud!
              ? 1
              : 0
          : 0,
      hiveYaumiActiveModel!.dhuha!
          ? hiveYaumiModel!.dhuha!
              ? 1
              : 0
          : 0,
      hiveYaumiActiveModel!.rawatib!
          ? hiveYaumiModel!.rawatib!
              ? 1
              : 0
          : 0,
      hiveYaumiActiveModel!.tilawah!
          ? hiveYaumiModel!.tilawah!
              ? 1
              : 0
          : 0,
      hiveYaumiActiveModel!.shaum!
          ? hiveYaumiModel!.shaum!
              ? 1
              : 0
          : 0,
      hiveYaumiActiveModel!.sedekah!
          ? hiveYaumiModel!.sedekah!
              ? 1
              : 0
          : 0,
      hiveYaumiActiveModel!.dzikir!
          ? (hiveYaumiModel!.dzikirPagi! ? 1 : 0) +
              (hiveYaumiModel!.dzikirPetang! ? 1 : 0)
          : 0,
      hiveYaumiActiveModel!.taklim!
          ? hiveYaumiModel!.taklim!
              ? 1
              : 0
          : 0,
      hiveYaumiActiveModel!.istighfar!
          ? hiveYaumiModel!.istighfar!
              ? 1
              : 0
          : 0,
      hiveYaumiActiveModel!.shalawat!
          ? hiveYaumiModel!.shalawat!
              ? 1
              : 0
          : 0
    ];
    yaumiLogController!
        .calculateMyTotalPoints(hiveYaumiActiveModelList, yaumiModelList);
    return ListTile(
      leading: const Icon(Icons.description),
      title: Text(tanggal),
      subtitle:
          Text('${yaumiLogController!.myTotalPoints.value.roundToDouble()} %'),
      trailing: const Icon(Icons.arrow_right),
      onTap: () => Get.to(() => YaumiLogDetails(
            hiveYaumiModel: hiveYaumiModel,
            hiveYaumiActiveModel: hiveYaumiActiveModel,
            tanggal: tanggalList,
          )),
    );
  }
}
