import 'package:adhan/adhan.dart';
import 'package:amala/constants/core_data.dart';
import 'package:amala/pages/home/widgets/adhan_times.dart';
import 'package:amala/pages/home/widgets/date_location_header.dart';
import 'package:amala/pages/home/widgets/my_date_picker.dart';
import 'package:amala/pages/home/widgets/user_bar.dart';
import 'package:amala/pages/home/widgets/yaumi_page.dart';
import 'package:amala/services/admob_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:upgrader/upgrader.dart';

import '../../services/adhan_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  final User? _user = FirebaseAuth.instance.currentUser;
  Coordinates? myCoordinate;
  AnimationController? _animationController;

  BannerAd? _bannerAd;
  bool _bannerAdLoaded = false;
  void loadAd() {
    _bannerAd = BannerAd(
      adUnitId: AdMobService.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            _bannerAdLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void initState() {
    myCoordinate = Coordinates(CoreData.lat, CoreData.lon);
    AdhanService().calculatePrayerTimes(myCoordinate!);
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: CoreData.levelClock));
    _animationController!.forward();
    loadAd();
    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context, builder: (context) => _logoutAlert(context));
        return true;
      },
      child: UpgradeAlert(
        upgrader: Upgrader(
            canDismissDialog: true,
            durationUntilAlertAgain: const Duration(days: 1),
            languageCode: 'id',
            dialogStyle: UpgradeDialogStyle.material),
        child: Scaffold(
          backgroundColor: Colors.indigo[50],
          body: SafeArea(
            child: Column(
              children: [
                //date, location
                DateLocationHeader(
                  hari: DateFormat('EEEE', "id_ID").format(DateTime.now()),
                  tanggal:
                      DateFormat('dd MMM yyyy', "id_ID").format(DateTime.now()),
                  wilayah: CoreData.wilayah,
                  kota: CoreData.kota,
                ),

                //userbar
                Userbar(
                  user: _user,
                ),

                _bannerAdLoaded
                    ? SizedBox(
                        width: _bannerAd!.size.width.toDouble(),
                        height: _bannerAd!.size.height.toDouble(),
                        child: AdWidget(ad: _bannerAd!),
                      )
                    : const SizedBox(),
                //adhan
                AdhanTimes(
                  shalatTitle: 'Shalat Dhuhur',
                  shalatTimes: '12:05',
                  nextShalatTimes: '00:03:00',
                  animationController: _animationController,
                ),

                //datepicker
                const MyDatePicker(),

                //yaumi
                YaumiPage(
                  user: _user,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _logoutAlert(BuildContext context) {
    return AlertDialog(
      content: const Text('Keluar Aplikasi?'),
      actions: [
        TextButton(onPressed: () {}, child: const Text('Yes')),
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text('No')),
      ],
    );
  }
}
