import 'package:amala/constants/core_data.dart';
import 'package:amala/constants/my_strings.dart';
import 'package:amala/constants/my_text_styles.dart';
import 'package:amala/models/user_model.dart';
import 'package:amala/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amala/controllers/group_controller.dart';

import 'group_list.dart';

class GroupListPage extends StatefulWidget {
  const GroupListPage({super.key});

  @override
  State<GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  final groupController = Get.put(GroupController());
  @override
  Widget build(BuildContext context) {
    final userModels = UserModels()
      ..uid = CoreData.uid
      ..uidGroup = CoreData.uidGroup
      ..uidLeader = CoreData.uidLeader
      ..nama = CoreData.nama
      ..amanah = CoreData.amanah
      ..email = CoreData.email
      ..group = CoreData.group
      ..lembaga = CoreData.lembaga
      ..password = CoreData.password
      ..ponsel = CoreData.ponsel
      ..absen = {}
      ..yaumi = {};
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          )),
          isScrollControlled: true,
          context: context,
          builder: (context) => Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: _buildSheet(userModels),
          ),
        ),
        label: const Text('Buat Group'),
        icon: Image.asset(
          MyStrings.manIconColor,
          scale: 3.5,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            GroupList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSheet(UserModels userModels) {
    return SizedBox(
      height: 300.0,
      child: Column(
        children: [
          const SizedBox(
            height: 8.0,
          ),
          Container(
            width: 75.0,
            height: 3.0,
            color: Colors.blueGrey,
          ),
          const SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                alignment: Alignment.centerLeft,
                child: const Text('Group Baru')),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1.0,
            color: Colors.blueGrey[300],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama Group',
                  style: MyTextStyles.header(),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  decoration: const InputDecoration(
                      hintText: 'Tulis nama group anda..',
                      border: OutlineInputBorder()),
                  onChanged: (val) => groupController.namaGroup.value = val,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1.0,
            color: Colors.blueGrey[300],
          ),
          const SizedBox(
            height: 8.0,
          ),
          ElevatedButton(
            onPressed: () async {
              // await DatabaseService(uid: CoreData.uid).setGroupData(
              //     uidGroup: CoreData.uid,
              //     uidLeader: CoreData.uid,
              //     namaGroup: groupController.namaGroup.value,
              //     member: []);
            },
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * .5,
              child: const Text('Buat Group'),
            ),
          )
        ],
      ),
    );
  }
}
