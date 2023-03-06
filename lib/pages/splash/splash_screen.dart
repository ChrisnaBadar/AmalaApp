import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../controllers/splash_controller.dart';
import '../../models/hive/boxes.dart';
import '../../models/hive/hive_yaumi_active_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController c = SplashController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo[50],
        body: ValueListenableBuilder<Box<HiveYaumiActiveModel>>(
          valueListenable: Boxes.getYaumiActiveModel().listenable(),
          builder: (context, box, _) {
            final yaumiActiveModel =
                box.values.toList().cast<HiveYaumiActiveModel>();
            if (yaumiActiveModel.isEmpty) {
              print('yaumiActiveModel is empty');
              c.toWelcomeScreen();
              return _mainBody();
            } else {
              print('yaumiActiveModel is not empty');
              c.toHompageScreen();
              return _mainBody();
            }
          },
        ));
  }

  Widget _mainBody() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Title of Apps
            SizedBox(),
            Text('${c.appTitle}',
                style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey)),
            Column(
              children: [
                SpinKitFadingCube(
                  color: Colors.amber,
                  size: 20.0,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text('App Version v. ${c.appVersion}',
                    style: TextStyle(color: Colors.blueGrey)),
                SizedBox(
                  height: 8.0,
                )
              ],
            )
            //Loading Icon

            //Version
          ]),
    );
  }
}
