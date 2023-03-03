import 'package:amala/constants/my_strings.dart';
import 'package:amala/pages/welcomePage/widget/page_body.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final pageController = PageController();
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
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue.shade700,
                  minimumSize: const Size.fromHeight(80)),
              onPressed: () {},
              child: const Text(
                'Mulai',
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
                    effect: WormEffect(
                        spacing: 16,
                        dotColor: Colors.black38,
                        activeDotColor: Colors.amber.shade700),
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
}
