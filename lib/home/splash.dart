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
  Widget build(BuildContext context) {
    splashController.toWelcomePage();
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
            ),
            const Text(MyStrings.appName,
                style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold)),
            Column(
              children: const [
                SpinKitDancingSquare(
                  color: Colors.amber,
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  MyStrings.checkingVersion,
                  style: TextStyle(
                      fontSize: 12.0,
                      color: Color.fromARGB(255, 122, 122, 122)),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  'V. ${MyStrings.appVersion}',
                  style: TextStyle(
                      fontSize: 12.0, color: Color.fromARGB(255, 7, 50, 160)),
                ),
                SizedBox(
                  height: 6.0,
                ),
              ],
            )
          ]),
    );
  }
}
