import 'package:amala/constants/my_strings.dart';
import 'package:flutter/material.dart';

class GroupTile extends StatefulWidget {
  const GroupTile({super.key});

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Image.asset(
            MyStrings.manIconColor,
            scale: 3,
          ),
        ),
        title: const Text('Group Title'),
        subtitle: const Text('Group Details'),
        trailing: Column(
          children: const [Text('Jumlah Anggota:'), Text('13 Orang')],
        ),
        isThreeLine: true,
      ),
    );
  }
}
