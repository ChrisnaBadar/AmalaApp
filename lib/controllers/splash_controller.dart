import 'dart:async';
import 'package:amala/constants/core_data.dart';
import 'package:amala/home/home.dart';
import 'package:amala/pages/welcomePage/welcome_page.dart';
import 'package:get/get.dart';
import 'package:amala/services/location_service.dart';

class SplashController extends GetxController {
  void toHome() async {
    try {
      List myLocation = await LocationService()
          .getLocation()
          .then((value) => value)
          .timeout(Duration(seconds: 10));
      CoreData.kota = myLocation[0];
      CoreData.wilayah = myLocation[1];
      CoreData.lat = myLocation[2];
      CoreData.lon = myLocation[3];

      print(
          'setelah locationService:\nkota: ${CoreData.kota}\nwilayah: ${CoreData.wilayah}\nlat: ${CoreData.lat}\nlon: ${CoreData.lon}');

      //Get.off(() => const Home());
    } on TimeoutException catch (e) {
      print('timeout error: $e');
      //Get.off(() => const Home());
    } catch (e) {
      print('error: $e');
      //Get.off(() => const Home());
    }
  }

  void toWelcomePage() async {
    try {
      List myLocation = await LocationService()
          .getLocation()
          .then((value) => value)
          .timeout(Duration(seconds: 10));
      CoreData.kota = myLocation[0];
      CoreData.wilayah = myLocation[1];
      CoreData.lat = myLocation[2];
      CoreData.lon = myLocation[3];

      Get.off(() => const WelcomePage());
    } on TimeoutException catch (e) {
      print('timeout error: $e');
      Get.off(() => const WelcomePage());
    } catch (e) {
      print('error: $e');
      Get.off(() => const WelcomePage());
    }
  }
}
