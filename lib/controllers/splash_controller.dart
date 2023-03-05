import 'dart:async';
import 'package:amala/pages/home/home.dart';
import 'package:amala/pages/welcomePage/welcome_page.dart';
import 'package:get/get.dart';
import 'package:amala/services/location_service.dart';

class SplashController extends GetxController {
  void toHome() async {
    try {
      await LocationService().getLocation();
      Get.off(() => const Home());
    } on TimeoutException catch (e) {
      Get.off(() => const Home());
    } catch (e) {
      Get.off(() => const Home());
    }
  }

  void toWelcomePage() async {
    try {
      await LocationService().getLocation();
      Get.off(() => const WelcomePage());
    } on TimeoutException catch (e) {
      Get.off(() => const WelcomePage());
    } catch (e) {
      Get.off(() => const WelcomePage());
    }
  }
}
