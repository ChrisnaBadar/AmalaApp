import 'dart:async';
import 'dart:io';
import 'package:amala/constants/core_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../pages/home/homepage.dart';
import '../pages/welcomePage/welcome_page.dart';
import '../services/location_service.dart';

//metoda masuk
class SplashController extends GetxController {
  var appTitle = CoreData.appName;
  var appVersion = CoreData.appVersion;
  bool goodInternet = false;
  final User? _user = FirebaseAuth.instance.currentUser;

  //to Homepage
  void toHompageScreen() async {
    try {
      List myLocation = await LocationService()
          .getLocation()
          .then((value) => value)
          .timeout(Duration(seconds: 10));
      CoreData.kota = myLocation[0];
      CoreData.wilayah = myLocation[1];
      CoreData.lat = myLocation[2];
      CoreData.lon = myLocation[3];

      Get.off(() => Homepage());
    } on TimeoutException catch (e) {
      print('Yang Pertama: $e');
      Get.off(() => Homepage());
    } catch (e) {
      print('Yang kedua: $e');
      Get.off(() => Homepage());
    }
  }

  void toWelcomeScreen() async {
    try {
      List myLocation = await LocationService()
          .getLocation()
          .then((value) => value)
          .timeout(Duration(seconds: 10));
      CoreData.kota = myLocation[0];
      CoreData.wilayah = myLocation[1];
      CoreData.lat = myLocation[2];
      CoreData.lon = myLocation[3];

      Get.off(() => WelcomePage());
    } on TimeoutException catch (e) {
      print('Yang Pertama: $e');
      Get.off(() => WelcomePage());
    } catch (e) {
      print('Yang kedua: $e');
      Get.off(() => WelcomePage());
    }
  }
}
