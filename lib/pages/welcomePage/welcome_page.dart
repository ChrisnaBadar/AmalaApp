import 'package:amala/constants/my_strings.dart';
import 'package:amala/constants/my_theme_data.dart';
import 'package:amala/models/hive/hive_user_model.dart';
import 'package:amala/pages/home/homepage.dart';

import 'package:amala/pages/welcomePage/widget/page_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controllers/yaumi_setting_controller.dart';
import '../../models/hive/boxes.dart';

class WelcomePage extends StatefulWidget {
  final String? kota;
  final String? wilayah;
  final double? lat;
  final double? lon;
  const WelcomePage({super.key, this.kota, this.wilayah, this.lat, this.lon});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final pageController = PageController();
  final settingsController = Get.put(YaumiSettingController());
  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: PageView(
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2;
            });
          },
          controller: pageController,
          children: const [
            PageBody(
                imageString: MyStrings.muslimCouple,
                title: MyStrings.page1Title,
                subtitle: MyStrings.page1Subtitle),
            PageBody(
                imageString: MyStrings.readingQuran,
                title: MyStrings.page2Title,
                subtitle: MyStrings.page2Subtitle),
            PageBody(
                imageString: MyStrings.startPlan,
                title: MyStrings.page3Title,
                subtitle: MyStrings.page3Subtitle),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0)),
                  foregroundColor: MyThemeData.accentColor,
                  backgroundColor: MyThemeData.primaryColor,
                  minimumSize: const Size.fromHeight(80)),
              onPressed: () {
                setFirstUserData();
                settingsController.tilawah.value = true;
                settingsController.updateData();
                Get.off(() => const Homepage());
              },
              child: const Text(
                MyStrings.mulai,
                style: TextStyle(fontSize: 24.0),
              ))
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 80.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      pageController.jumpToPage(2);
                    },
                    child: const Text(MyStrings.skip),
                  ),
                  Center(
                      child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: const WormEffect(
                        spacing: 16,
                        dotColor: MyThemeData.primaryColor,
                        activeDotColor: MyThemeData.alternativeColor),
                    onDotClicked: (index) => pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn),
                  )),
                  TextButton(
                    onPressed: () {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    child: const Text(MyStrings.next),
                  )
                ],
              ),
            ),
    );
  }

  void setFirstUserData() {
    final userHiveModel = HiveUserModel()
      ..uid = '-'
      ..uidGroup = '-'
      ..uidLeader = '-'
      ..nama = '-'
      ..email = '-'
      ..profilePicUrl = '-'
      ..group = '-'
      ..lembaga = '-'
      ..ponsel = '-'
      ..amanah = '-';
    final box = Boxes.getUserModel();
    box.put('user', userHiveModel);
  }
}
