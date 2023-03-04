import 'package:amala/constants/my_text_styles.dart';
import 'package:amala/constants/my_theme_data.dart';
import 'package:amala/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:amala/constants/my_strings.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final splashController = Get.put(SplashController());

  @override
  void initState() {
    // TODO: implement initState
    splashController.toWelcomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
            ),
            Text(MyStrings.appName, style: MyTextStyles.logo()),
            Column(
              children: [
                const SpinKitDancingSquare(
                  color: MyThemeData.accentColor,
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Text(
                  MyStrings.checkingVersion,
                  style: MyTextStyles.smallText(),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Text(
                  'V. ${MyStrings.appVersion}',
                  style: MyTextStyles.smallText(),
                ),
                const SizedBox(
                  height: 6.0,
                ),
              ],
            )
          ]),
    );
  }
}
