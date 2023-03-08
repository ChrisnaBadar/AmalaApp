import 'package:amala/constants/my_strings.dart';
import 'package:amala/constants/my_text_styles.dart';
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
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          )),
          context: context,
          builder: (context) => _buildSheet(),
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

  Widget _buildSheet() {
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
            onPressed: () {},
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
