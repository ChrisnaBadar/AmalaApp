import 'package:amala/blocs/bloc_exports.dart';
import 'package:amala/constants/core_data.dart';
import 'package:amala/models/users_model.dart';
import 'package:amala/pages/splash_screen/controller/splash_controller.dart';
import 'package:amala/services/database_service.dart';
import 'package:amala/services/location_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final _splashController = SplashController();
  final User? _user = FirebaseAuth.instance.currentUser;
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
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (settingsContext, settingsState) {
        CoreData.adhanAlarm = settingsState.shalatReminder;
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            final uid = state.uid;
            final nama = state.nama;
            final email = state.email;
            final profilePicUrl = state.photoUrl;
            return StreamBuilder<UsersModel>(
              stream: DatabaseService(uid: uid == '' ? '-' : uid).userData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print('has data');
                  final userModel = snapshot.data;
                } else {
                  print('no data');
                }
                return _mainBody(appVersion);
              },
            );
          },
        );
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
          SizedBox(
              child: Text(
            'Amala',
            style: TextStyle(
                fontFamily: 'Raleway',
                color: Colors.amber[100],
                fontWeight: FontWeight.bold,
                fontSize: 50.0),
          )),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SpinKitDancingSquare(
                  color: Colors.amber[600],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                const Text(
                  'Checking Version',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Amala App $appVersion',
                  style: const TextStyle(color: Colors.white),
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
