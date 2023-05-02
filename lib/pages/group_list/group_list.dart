// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:amala/models/groups_model.dart';

import 'group_tile.dart';

class GroupList extends StatefulWidget {
  final List<GroupsModel> groupsModel;
  const GroupList({
    Key? key,
    required this.groupsModel,
  }) : super(key: key);

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.groupsModel.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => GroupTile(
        groupsModel: widget.groupsModel[index],
      ),
    );
  }
}
