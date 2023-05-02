import 'package:flutter/material.dart';
import 'my_theme_data.dart';

class MyTextStyles {
  MyTextStyles._();

  static TextStyle logo() {
    return const TextStyle(
        fontSize: 55.0,
        fontWeight: FontWeight.bold,
        color: MyThemeData.secondaryTextColor);
  }

  static TextStyle bigText() {
    return const TextStyle(
        fontSize: 35.0,
        fontWeight: FontWeight.bold,
        color: MyThemeData.primaryTextColor);
  }

  static TextStyle header() {
    return const TextStyle(
        fontSize: 20.5,
        fontWeight: FontWeight.bold,
        color: MyThemeData.primaryTextColor);
  }

  static TextStyle header2() {
    return const TextStyle(
        fontSize: 17.5,
        fontWeight: FontWeight.bold,
        color: MyThemeData.primaryTextColor);
  }

  static TextStyle paragraph() {
    return const TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
        color: MyThemeData.primaryTextColor);
  }

  static TextStyle smallText() {
    return const TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: MyThemeData.primaryTextColor);
  }
}
