import 'package:flutter/material.dart';

import '../../models/group_model.dart';
import 'group_tile.dart';

class GroupList extends StatefulWidget {
  final List<GroupModel>? groupList;
  const GroupList({super.key, this.groupList});

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.groupList!.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => GroupTile(
        groupModel: widget.groupList![index],
      ),
    );
  }
}
