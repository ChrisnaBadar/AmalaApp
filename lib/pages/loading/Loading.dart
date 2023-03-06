import 'package:amala/constants/my_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDancingSquare(
          color: MyThemeData.primaryColor,
        ),
      ),
    );
  }
}
