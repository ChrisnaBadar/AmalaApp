import 'package:amala/constants/my_strings.dart';
import 'package:flutter/material.dart';

Widget amalaCategoryTile() {
  return ListTile(
    leading: Image.asset(
      MyStrings.fardhuIconColor,
      scale: 2,
    ),
    title: const Text('title'),
    trailing: const Icon(Icons.check_box_outline_blank),
  );
}
