import 'package:amala/blocs/bloc_exports.dart';
import 'package:amala/constants/core_data.dart';
import 'package:amala/constants/my_strings.dart';
import 'package:amala/pages/splash_screen/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final _splashController = SplashController();
  AnimationController? _animationController;
  @override
  void initState() {
    _splashController.locationFetch(context);
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: CoreData.locationFetchDuration));
    _animationController!.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appVersion = CoreData.appVersion;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return _mainBody(appVersion);
      },
    );
  }

  _mainBody(appVersion) {
    return Scaffold(
      backgroundColor: Colors.indigo[400],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Column(
            children: [
              SpinKitDancingSquare(
                color: Colors.amber[600],
              ),
              const SizedBox(
                height: 8.0,
              ),
              SizedBox(
                  child: Text(
                'Amala',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.amber[100],
                    fontWeight: FontWeight.bold,
                    fontSize: 50.0),
              )),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Checking Version',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Amala App $appVersion',
                  style: const TextStyle(color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 8.0,
                    ),
                    const Text(
                      'Powered by:',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Image.asset(
                      MyStrings.gsp,
                      scale: 3,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Countdown(
                  animation:
                      StepTween(begin: CoreData.locationFetchDuration, end: 0)
                          .animate(_animationController!),
                ),
              ],
            ),
          )
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
        clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0');

    return Text(
      "Mencari lokasi ... ($timerText)",
      style: const TextStyle(
        fontSize: 11.0,
        color: Colors.white,
      ),
    );
  }
}
