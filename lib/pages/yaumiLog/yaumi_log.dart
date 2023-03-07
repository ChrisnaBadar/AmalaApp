import 'package:amala/pages/yaumiLog/widgets/yaumi_log_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/hive/boxes.dart';
import '../../models/hive/hive_yaumi_active_model.dart';
import '../../models/hive/hive_yaumi_model.dart';
import '../../models/user_model.dart';
import '../../models/yaumi_model.dart';
import '../../services/database_service.dart';
import 'controller/yaumi_log_controller.dart';

class YaumiLog extends StatefulWidget {
  const YaumiLog({Key? key}) : super(key: key);

  @override
  State<YaumiLog> createState() => _YaumiLogState();
}

class _YaumiLogState extends State<YaumiLog> {
  final _controller = Get.put(YaumiLogController());
  final User? _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModels>(
        stream: DatabaseService(uid: _user!.uid).yaumiModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data;
            final yaumiData =
                userData!.yaumi!.entries.map((e) => e.value).toList();
            final yaumiDateModel = List.generate(
                yaumiData.length,
                (index) => YaumiModel(
                      tanggal: yaumiData[index]['tanggal'],
                    ));
            final yaumiDateResult =
                yaumiDateModel.map((e) => e.tanggal).toList();
            return _mainBody(dateResult: yaumiDateResult);
          } else {
            return _mainBody();
          }
        });
  }

  Widget _mainBody({List? dateResult}) {
    List? result = dateResult;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Yaumi'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ValueListenableBuilder<Box<HiveYaumiActiveModel>>(
            valueListenable: Boxes.getYaumiActiveModel().listenable(),
            builder: (context, box, _) {
              final hiveYaumiActiveModel =
                  box.values.toList().cast<HiveYaumiActiveModel>();
              if (hiveYaumiActiveModel.isEmpty) {
                return Container();
              } else {
                return ValueListenableBuilder<Box<HiveYaumiModel>>(
                    valueListenable: Boxes.getYaumiModel().listenable(),
                    builder: (context, box, _) {
                      final hiveYaumiModel =
                          box.values.toList().cast<HiveYaumiModel>();
                      if (hiveYaumiModel.isEmpty) {
                        return Container();
                      } else {
                        return YaumiLogList(
                          hiveYaumiModel: hiveYaumiModel,
                          hiveYaumiActiveModel: hiveYaumiActiveModel,
                          yaumiLogController: _controller,
                          tanggal: result ?? [''],
                        );
                      }
                    });
              }
            },
          ),
        ),
      ),
    );
  }
}
