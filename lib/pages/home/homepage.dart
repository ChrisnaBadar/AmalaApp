import 'package:amala/constants/my_strings.dart';
import 'package:amala/controllers/home_controller.dart';
import 'package:amala/controllers/yaumi_setting_controller.dart';
import 'package:amala/models/hive/boxes.dart';
import 'package:amala/models/hive/hive_user_model.dart';
import 'package:amala/models/hive/hive_yaumi_active_model.dart';
import 'package:amala/models/hive/hive_yaumi_model.dart';
import 'package:amala/pages/home/widgets/adhanTimes.dart';
import 'package:amala/pages/home/widgets/dailyProgressBar.dart';
import 'package:amala/pages/home/widgets/habitChecklist.dart';
import 'package:amala/pages/home/widgets/notificationsContainer.dart';
import 'package:amala/pages/home/widgets/profilesBar.dart';
import 'package:amala/pages/home_habitChecklistDetails/controllers/habitChecklistController.dart';
import 'package:amala/pages/yaumi_setting/yaumi_setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:adhan/adhan.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:amala/constants/core_data.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  final _homeController = Get.put(HomeController());
  final _habitController = Get.put(HabitChecklistController());
  final _settingsController = Get.put(YaumiSettingController());
  AnimationController? _animationController;

  final User? _user = FirebaseAuth.instance.currentUser;
  var myCoordinate;

  var uidGroup;
  var uidLeader;
  var lembaga;
  var amanah;
  var group;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeController.dailyProgressSelectedValue.value = {
      'day': DateFormat('EEEE', "id_ID").format(DateTime.now()),
      'date': DateFormat('dd').format(DateTime.now())
    };
    myCoordinate = Coordinates(CoreData.lat, CoreData.lat);
    _homeController.calculatePrayerTimes(myCoordinate);
    _homeController.activatedCategory = [].obs;
    _homeController.iconCheck = [].obs;
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: _homeController.levelClock.value));
    _animationController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<HiveUserModel>>(
        valueListenable: Boxes.getUserModel().listenable(),
        builder: (context, box, _) {
          final userHiveModel = box.values.toList().cast<HiveUserModel>();
          if (userHiveModel.isEmpty) {
            return _mainBody();
          } else {
            return _mainBody(hiveUserModel: userHiveModel.first);
          }
        });
  }

  Widget _mainBody({HiveUserModel? hiveUserModel}) {
    return ValueListenableBuilder<Box<HiveYaumiActiveModel>>(
        valueListenable: Boxes.getYaumiActiveModel().listenable(),
        builder: ((context, box, _) {
          final hiveYaumiActiveModel =
              box.values.toList().cast<HiveYaumiActiveModel>();
          if (hiveYaumiActiveModel.isEmpty) {
            _settingsController.setFirstActivator();
            return Container();
          } else {
            _homeController.activatedCategory.value = [
              hiveYaumiActiveModel.first.fardhu,
              hiveYaumiActiveModel.first.tahajud,
              hiveYaumiActiveModel.first.dhuha,
              hiveYaumiActiveModel.first.rawatib,
              hiveYaumiActiveModel.first.tilawah,
              hiveYaumiActiveModel.first.shaum,
              hiveYaumiActiveModel.first.sedekah,
              hiveYaumiActiveModel.first.dzikir,
              hiveYaumiActiveModel.first.taklim,
              hiveYaumiActiveModel.first.istighfar,
              hiveYaumiActiveModel.first.shalawat
            ];
            return ValueListenableBuilder<Box<HiveYaumiModel>>(
                valueListenable: Boxes.getYaumiModel().listenable(),
                builder: (context, box, _) {
                  final hiveYaumiModel =
                      box.values.toList().cast<HiveYaumiModel>();
                  final hiveYaumiModelSingleData = hiveYaumiModel
                      .where((element) =>
                          element.tanggal == _homeController.selectedDate.value)
                      .toList();
                  if (hiveYaumiModelSingleData.isEmpty) {
                    _habitController
                        .setFirstData(_homeController.selectedDate.value);
                    return Scaffold();
                  } else {
                    final singleDataValue =
                        hiveYaumiModelSingleData.map((e) => e.isSaved).first;
                    _homeController.isSaved.value = singleDataValue!;
                    _homeController.checkListResult.value =
                        hiveYaumiModelSingleData;
                    var cShubuh =
                            _homeController.checkListResult.value.first.shubuh,
                        cDhuhur =
                            _homeController.checkListResult.value.first.dhuhur,
                        cAshar =
                            _homeController.checkListResult.value.first.ashar,
                        cMaghrib =
                            _homeController.checkListResult.value.first.maghrib,
                        cIsya =
                            _homeController.checkListResult.value.first.isya,
                        cTahajud =
                            _homeController.checkListResult.value.first.tahajud,
                        cDhuha =
                            _homeController.checkListResult.value.first.dhuha,
                        cRawatib =
                            _homeController.checkListResult.value.first.rawatib,
                        cTilawah =
                            _homeController.checkListResult.value.first.tilawah,
                        cShaum =
                            _homeController.checkListResult.value.first.shaum,
                        cSedekah =
                            _homeController.checkListResult.value.first.sedekah,
                        cDzikirPagi = _homeController
                            .checkListResult.value.first.dzikirPagi,
                        cDzikirPetang = _homeController
                            .checkListResult.value.first.dzikirPetang,
                        cTaklim =
                            _homeController.checkListResult.value.first.taklim,
                        cIstighfar = _homeController
                            .checkListResult.value.first.istighfar,
                        cShalawat = _homeController
                            .checkListResult.value.first.shalawat;
                    List iconCheck = [
                      [cShubuh, cDhuhur, cAshar, cMaghrib, cIsya].contains(true)
                          ? true
                          : false,
                      cTahajud,
                      cDhuha,
                      cRawatib,
                      cTilawah,
                      cShaum,
                      cSedekah,
                      [cDzikirPagi, cDzikirPetang].contains(true)
                          ? true
                          : false,
                      cTaklim,
                      cIstighfar,
                      cShalawat
                    ];
                    _homeController.iconCheck.value = iconCheck;
                    return _mHomePage(
                        yaumiActiveModel: hiveYaumiActiveModel,
                        hiveYaumiModel: hiveYaumiModel,
                        iconCheck: _homeController.iconCheck,
                        hiveUserModel: hiveUserModel!);
                  }
                });
          }
        }));
  }

  Widget _mHomePage(
      {@required List<HiveYaumiActiveModel>? yaumiActiveModel,
      @required List<HiveYaumiModel>? hiveYaumiModel,
      @required List? iconCheck,
      @required HiveUserModel? hiveUserModel}) {
    return Scaffold(
        //BACKGROUND COLOR
        backgroundColor: Colors.blueGrey[50],

        //FAB=============
        //if (activatedCategory.notContains(true))
        floatingActionButton: _user != null
            ? Obx(() => _homeController.activatedCategory.contains(true)
                ? _homeController.iconCheck.contains(true)
                    ? !_homeController.isSaved.value
                        ? FloatingActionButton.extended(
                            onPressed: () => showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    Obx(() => _buildDialog(false))),
                            label: Text('SAVE'),
                            icon: Image.asset(
                              MyStrings.saveIconColor,
                              scale: 2,
                            ),
                          )
                        : FloatingActionButton.extended(
                            onPressed: () => showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    Obx(() => _buildDialog(true))),
                            label: Text('UPDATE'),
                            icon: Image.asset(
                              MyStrings.updateIconColor,
                              scale: 2,
                            ),
                            backgroundColor: Colors.green,
                          )
                    : Container()
                : Container())
            : Container(),

        //BODY================
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              //profile bar
              profilesBar(context, _user, CoreData.kota, CoreData.wilayah,
                  hiveUserModel!),

              hiveUserModel.lembaga == 'PTGSP'
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                          onPressed: null, //() => Get.to(() => AbsenPage()),
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            child: Text('ABSEN'),
                          )),
                    )
                  : Container(),

              //tes
              // ElevatedButton(
              //   onPressed: () => Get.to(() => TestPage()),
              //   child: Text('To Test Page'),
              // ),

              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: AdhanTimes(
                      coordinate: myCoordinate,
                      animationController: _animationController,
                      homeController: _homeController,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: notificationsContainer(context: context),
                  )
                ],
              ),

              //Level indicator
              // progressLevel(
              //     context: context,
              //     widgetSpacing: 8.0,
              //     imageSize: MediaQuery.of(context).size.width * .25,
              //     leftWidth: MediaQuery.of(context).size.width * .27,
              //     rightWidth: MediaQuery.of(context).size.width * .67,
              //     expWidth: MediaQuery.of(context).size.width * .65,
              //     expPoint: .5,
              //     totalExp: 100,
              //     currentExp: 50),

              dailyProgressBar(
                  context: context,
                  homeController: _homeController,
                  habitController: _habitController,
                  hiveYaumiModel: hiveYaumiModel),

              //Detail checklist habit
              habitChecklist(
                  context: context,
                  toYaumiSettings: () => Get.to(() => const YaumiSetting()),
                  toYaumiLog: null,
                  // () => Get.to(() => YaumiLogReport(
                  //       hiveYaumiModel: hiveYaumiModel,
                  //     )),
                  habitChecklistController: _habitController,
                  homeController: _homeController,
                  iconsCheck: iconCheck,
                  yaumiActiveModel: yaumiActiveModel,
                  hiveYaumiModel: hiveYaumiModel),
            ],
          ),
        )));
  }

  Widget _buildDialog(bool saved) {
    var date = DateFormat('EEEE, dd MMM yyyy', "id_ID")
        .format(_homeController.selectedDate.value);
    var yaumiList = [
      _habitController.shubuh.value,
      _habitController.dhuhur.value,
      _habitController.ashar.value,
      _habitController.maghrib.value,
      _habitController.isya.value,
      _habitController.tahajud.value,
      _habitController.dhuha.value,
      _habitController.rawatib.value,
      _habitController.tilawah.value,
      _habitController.shaum.value,
      _habitController.sedekah.value,
      _habitController.dzikirPagi.value,
      _habitController.dzikirPetang.value,
      _habitController.taklim.value,
      _habitController.istighfar.value,
      _habitController.shalawat.value,
      _habitController.point.value
    ];
    print(saved);
    return Stack(children: [
      ValueListenableBuilder<Box<HiveUserModel>>(
        valueListenable: Boxes.getUserModel().listenable(),
        builder: (context, box, _) {
          final userHiveModel = box.values.toList().cast<HiveUserModel>();
          if (userHiveModel.isEmpty) {
            return Container();
          } else {
            uidGroup = userHiveModel.first.uidGroup;
            uidLeader = userHiveModel.first.uidLeader;
            lembaga = userHiveModel.first.lembaga;
            amanah = userHiveModel.first.amanah;
            group = userHiveModel.first.group;
            return ValueListenableBuilder<Box<HiveYaumiModel>>(
              valueListenable: Boxes.getYaumiModel().listenable(),
              builder: (context, box, _) {
                final hiveYaumiModel =
                    box.values.toList().cast<HiveYaumiModel>();
                final todayYaumi = hiveYaumiModel
                    .where((element) =>
                        element.tanggal == _homeController.selectedDate.value)
                    .first;
                if (hiveYaumiModel.isEmpty) {
                  return Container();
                } else {
                  return AlertDialog(
                    title: saved
                        ? Text('UPDATE DATA YAUMI')
                        : Text('SAVE DATA YAUMI'),
                    content: Text.rich(TextSpan(children: [
                      saved
                          ? TextSpan(text: 'Update data Yaumi ini? ')
                          : TextSpan(text: 'Save data Yaumi hari '),
                      TextSpan(
                          text: '$date ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'ke cloud data base?')
                    ])),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (saved) {
                            print('saved');
                            _homeController.saveLoading.value = true;
                            try {
                              // await DatabaseService(uid: _user.uid)
                              //     .setDataYaumi(
                              //         _homeController.selectedDate.value,
                              //         yaumiList,
                              //         true,
                              //         _habitController.point.value);
                              _habitController.isSaved.value = true;
                              _habitController.setSavedValue(
                                  tanggal: _homeController.selectedDate.value,
                                  yaumi: yaumiList);
                              _homeController.saveLoading.value = false;
                              print('success');
                              Navigator.pop(context, 'OK');
                            } catch (e) {
                              print('failed');
                              _homeController.saveLoading.value = false;
                              Navigator.pop(context, 'OK');
                            }
                          } else {
                            _homeController.saveLoading.value = true;
                            print(
                                'not saved: ${_homeController.saveLoading.value}');
                            try {
                              // await DatabaseService(uid: _user.uid)
                              //     .setDataYaumi(
                              //         _homeController.selectedDate.value,
                              //         yaumiList,
                              //         _habitController.isSaved.value,
                              //         _habitController.point.value);
                              _homeController.saveLoading.value = false;
                              _habitController.isSaved.value = true;
                              _habitController.setSavedValue(
                                  tanggal: _homeController.selectedDate.value,
                                  yaumi: yaumiList);
                              print('tried: ${_user!.uid}');
                              Navigator.pop(context, 'OK');
                            } catch (e) {
                              print('catched: $e');
                              _homeController.saveLoading.value = false;
                              Navigator.pop(context, 'OK');
                            }
                          }
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                }
              },
            );
          }
        },
      ),
      _homeController.saveLoading.value
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.grey.withOpacity(.4),
            )
          : Container(),
      _homeController.saveLoading.value
          ? SpinKitFadingCube(
              color: Colors.amber,
            )
          : Container(),
    ]);
  }
}
