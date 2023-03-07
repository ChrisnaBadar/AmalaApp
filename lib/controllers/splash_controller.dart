import 'dart:async';
import 'package:amala/constants/core_data.dart';
import 'package:get/get.dart';

import '../pages/home/homepage.dart';
import '../pages/welcomePage/welcome_page.dart';
import '../services/location_service.dart';

//metoda masuk
class SplashController extends GetxController {
  var appTitle = CoreData.appName;
  var appVersion = CoreData.appVersion;
  bool goodInternet = false;

  //to Homepage
  void toHompageScreen() async {
    try {
      List myLocation = await LocationService()
          .getLocation()
          .then((value) => value)
          .timeout(const Duration(seconds: 10));
      CoreData.kota = myLocation[0];
      CoreData.wilayah = myLocation[1];
      CoreData.lat = myLocation[2];
      CoreData.lon = myLocation[3];

      Get.off(() => const Homepage());
    } on TimeoutException catch (e) {
      Get.off(() => const Homepage());
    } catch (e) {
      Get.off(() => const Homepage());
    }
  }

  void toWelcomeScreen() async {
    try {
      List myLocation = await LocationService()
          .getLocation()
          .then((value) => value)
          .timeout(const Duration(seconds: 10));
      CoreData.kota = myLocation[0];
      CoreData.wilayah = myLocation[1];
      CoreData.lat = myLocation[2];
      CoreData.lon = myLocation[3];

      Get.off(() => WelcomePage());
    } on TimeoutException catch (e) {
      Get.off(() => WelcomePage());
    } catch (e) {
      Get.off(() => WelcomePage());
    }
  }
}
