import 'package:amala/constants/core_data.dart';
import 'package:amala/controllers/home_controller.dart';
import 'package:amala/pages/home/widgets/amala_list.dart';
import 'package:amala/pages/home/widgets/daily_dates.dart';
import 'package:amala/pages/home/widgets/date_location_header.dart';
import 'package:amala/pages/home/widgets/shalat_schedule.dart';
import 'package:amala/pages/home/widgets/user_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final homeController = Get.put(HomeController());
  AnimationController? _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.calculatePrayerTimes(CoreData.coordinate);
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: homeController.levelClock.value));
    _animationController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //header tanggal & lokasi
              dateLocationHeader(context: context),

              //user bar
              const UserBar(),

              //shalat schedule
              ShalatSchedule(
                coordinate: CoreData.coordinate,
                animationController: _animationController,
                homeController: homeController,
              ),

              //daily dates
              const DailyDates(),

              //Amala sections
              const AmalaList()
            ],
          ),
        ),
      ),
    );
  }
}
