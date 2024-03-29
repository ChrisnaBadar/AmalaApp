import 'package:amala/models/users_model.dart';
import 'package:amala/models/yaumi_model.dart';
import 'package:amala/pages/log_yaumi/log_yaumi_list.dart';
import 'package:amala/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

import '../../blocs/bloc_exports.dart';
import '../../constants/my_strings.dart';
import '../../services/admob_service.dart';

class LogYaumiPage extends StatefulWidget {
  const LogYaumiPage({super.key});

  @override
  State<LogYaumiPage> createState() => _LogYaumiPageState();
}

class _LogYaumiPageState extends State<LogYaumiPage> {
  bool loading = false;
  List<String> months = List.generate(
      12,
      (index) => DateFormat('MMMM yyyy', "id_ID")
          .format(DateTime(DateTime.now().year, index + 1)));
  String dropdownValue = DateFormat('MMMM yyyy', "id_ID")
      .format(DateTime(DateTime.now().year, DateTime.now().month));

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

  _adWidget() {
    return _bannerAdLoaded
        ? SizedBox(
            width: _bannerAd!.size.width.toDouble(),
            height: _bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd!),
          )
        : const SizedBox();
  }

  @override
  void initState() {
    loadAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (userContext, userState) {
        return StreamBuilder<UsersModel>(
            stream: DatabaseService(uid: userState.uid).yaumiModel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data;
                final yaumiData =
                    userData!.yaumi!.entries.map((e) => e.value).toList();
                final yaumiDateModel = List.generate(
                    yaumiData.length,
                    (index) => YaumiModel(
                          id: yaumiData[index]['tanggal'],
                          date: (yaumiData[index]['date']).toDate(),
                          nama: (yaumiData[index]['nama']),
                          shubuh: yaumiData[index]['shubuh'],
                          dhuhur: yaumiData[index]['dhuhur'],
                          ashar: yaumiData[index]['ashar'],
                          maghrib: yaumiData[index]['maghrib'],
                          isya: yaumiData[index]['isya'],
                          rawatib: yaumiData[index]['rawatib'],
                          tahajud: yaumiData[index]['tahajud'],
                          dhuha: yaumiData[index]['dhuha'],
                          tilawah: yaumiData[index]['tilawah'],
                          shaum: yaumiData[index]['shaum'],
                          sedekah: yaumiData[index]['sedekah'],
                          taklim: yaumiData[index]['taklim'],
                          dzikirPagi: yaumiData[index]['dzikirPagi'],
                          dzikirPetang: yaumiData[index]['dzikirPetang'],
                          istighfar: yaumiData[index]['istighfar'],
                          shalawat: yaumiData[index]['shalawat'],
                          poinHariIni: yaumiData[index]['point'],
                          isSubmitted: yaumiData[index]['isSaved'],
                        ));
                final selectedDateData = yaumiDateModel
                    .where((e) =>
                        DateFormat('MMMM yyyy', "id_ID").format(e.date) ==
                        dropdownValue)
                    .toList();
                final sortedItems = selectedDateData
                  ..sort((a, b) => b.date.compareTo(a.date));
                return Scaffold(
                    bottomNavigationBar: _adWidget(),
                    body: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            //Header Absen
                            _headerLog(sortedItems, userData.uid!,
                                userData.uidLeader!),

                            //Bulan Dropdown
                            _bulanDropdownSortir(months),

                            //List Absen
                            Expanded(
                              child: LogYaumiList(allYaumis: sortedItems),
                            ),
                          ],
                        ),
                      ),
                    ));
              } else {
                return Scaffold(
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: loading
                        ? const SpinKitDancingSquare(
                            color: Colors.amber,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                const Text(
                                  'Jika anda melihat halaman ini anda harus memperbaharui data online dengan cara menekan tombol di bawah ini.',
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      try {
                                        await DatabaseService(
                                                uid: userState.uid)
                                            .updateUserData(
                                                userState.nama,
                                                userState.email,
                                                userState.photoUrl);
                                        setState(() {
                                          loading = false;
                                        });
                                      } catch (e) {
                                        await DatabaseService(
                                                uid: userState.uid)
                                            .setUserData(
                                                userState.nama,
                                                userState.email,
                                                userState.photoUrl);
                                        setState(() {
                                          loading = false;
                                        });
                                      }
                                    },
                                    child: const Text('Renew Data'))
                              ]),
                  ),
                );
              }
            });
      },
    );
  }

  Widget _headerLog(
      List<YaumiModel> sortedItems, String uid, String uidLeader) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Data Yaumi Online',
              style: TextStyle(
                  fontSize: 17.5,
                  color: Colors.blueGrey[700],
                  fontWeight: FontWeight.bold)),
          uid == uidLeader
              ? TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/yaumiPrintReportPage',
                        arguments: sortedItems);
                  },
                  icon: Image.asset(
                    MyStrings.docIconColor,
                    scale: 3,
                  ),
                  label: const Text('Online Data Report'))
              : Container()
        ],
      ),
    );
  }

  Widget _bulanDropdownSortir(List<String> months) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DropdownButton<String>(
            value: dropdownValue,
            items: months.map<DropdownMenuItem<String>>((e) {
              return DropdownMenuItem(value: e, child: Text(e));
            }).toList(),
            onChanged: (val) {
              setState(() {
                dropdownValue = val!;
              });
            }),
      ],
    );
  }
}
