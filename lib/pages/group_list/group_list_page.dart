import 'package:amala/constants/my_strings.dart';
import 'package:flutter/material.dart';

import 'group_list.dart';

class GroupListPage extends StatefulWidget {
  const GroupListPage({super.key});

  @override
  State<GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
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
    return Column(
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
              alignment: Alignment.centerLeft, child: const Text('Group Baru')),
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
        TextField(
          decoration: const InputDecoration(
              label: Text('Nama Group'), border: OutlineInputBorder()),
          onChanged: (val) {},
        )
      ],
    );
  }
}
