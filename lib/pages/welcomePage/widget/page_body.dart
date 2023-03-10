import 'package:amala/constants/my_theme_data.dart';
import 'package:flutter/material.dart';

class PageBody extends StatelessWidget {
  final String? imageString;
  final String? title;
  final String? subtitle;
  const PageBody({super.key, this.imageString, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      //Image
      Image.asset(
        imageString!,
        scale: 5,
      ),
      const SizedBox(
        height: 16.0,
      ),

      //Title
      Text(title!,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35.0,
              color: MyThemeData.secondaryTextColor)),
      const SizedBox(
        height: 16.0,
      ),

      //Description
      Text(subtitle!,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
              color: MyThemeData.primaryTextColor)),
      const SizedBox(
        height: 16.0,
      ),
    ]);
  }
}
