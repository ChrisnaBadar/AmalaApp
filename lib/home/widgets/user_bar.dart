import 'package:amala/constants/my_strings.dart';
import 'package:flutter/material.dart';

class UserBar extends StatelessWidget {
  const UserBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(MyStrings.manIconColor),
          ),
          title: Text('Nama User'),
          subtitle: Text('Info User'),
          trailing: Icon(Icons.arrow_right),
        ),
      ),
    );
  }
}
