import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controller.dart';

class AdhanTimes extends StatelessWidget {
  final Coordinates? coordinate;
  final AnimationController? animationController;
  final HomeController? homeController;
  const AdhanTimes(
      {super.key,
      this.coordinate,
      this.animationController,
      this.homeController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          const SizedBox(
            height: 16.0,
          ),
          Obx(() => Text(homeController!.shalatTitle.value,
              style: const TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.blueGrey))),
          const SizedBox(
            height: 4.0,
          ),
          Obx(
            () => Text(homeController!.shalatTimes.value,
                style: const TextStyle(
                    fontSize: 22.0, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 4.0,
          ),
          Obx(
            () => Countdown(
              animation:
                  StepTween(begin: homeController!.levelClock.value, end: 0)
                      .animate(animationController!),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
        ],
      ),
    );
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key? key, this.animation})
      : super(key: key, listenable: animation!);
  final Animation<int>? animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation!.value);

    String timerText =
        '${clockTimer.inHours.remainder(12).toString().padLeft(2, '0')}:${clockTimer.inMinutes.remainder(60).toString().padLeft(2, '0')}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return Text(
      "- $timerText",
      style: TextStyle(
        fontSize: 13.5,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
