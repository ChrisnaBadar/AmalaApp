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
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [Text('Jumlah Anggota:'), Text('13 Orang')],
        ),
        trailing: Image.asset(
          MyStrings.plusIconColor,
          scale: 1.5,
        ),
        isThreeLine: true,
      ),
    );
  }
}
