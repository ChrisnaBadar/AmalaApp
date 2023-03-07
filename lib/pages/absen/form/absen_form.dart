import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:amala/constants/my_strings.dart';
import 'package:amala/constants/core_data.dart';

import '../../../services/database_service.dart';
import '../../../services/location_service.dart';
import '../../loading/loading.dart';
import '../controllers/absen_controller.dart';

class AbsenForm extends StatefulWidget {
  final AbsenController? absenController;
  const AbsenForm({super.key, this.absenController});

  @override
  State<AbsenForm> createState() => _AbsenFormState();
}

class _AbsenFormState extends State<AbsenForm> {
  //untuk formbuilder
  final _formKey = GlobalKey<FormBuilderState>();
  FocusNode? _focusNode;
  final User? _user = FirebaseAuth.instance.currentUser;

  bool locationLoading = false;
  bool loading = false;
  bool wfo = false;
  bool wfh = false;
  bool ijin = false;
  bool sakit = false;
  bool? forUpdate;

  Map? infoUser;
  bool? absenDone;
  String? id;
  String? uid;
  String? nama;
  String? uidGroup;
  DateTime? tanggal;
  String? waktu;
  String? lokasi = CoreData.wilayah;
  String? wilayah = CoreData.wilayah;
  String? keperluan = '-';
  String? tanggalIjin = '-';
  String? bulan;
  String? tahun;
  String? approval;

  List absenOption = ['Pilih salah satu..', 'WFO', 'WFH', 'Sakit', 'Ijin'];
  List absenDoneOption = ['Pilih salah satu..', 'Ijin'];
  String? statusKehadiran;

  // void _showIntertitialAd() {
  //   InterstitialAd.load(
  //       adUnitId: AdMobService.interstitialAdUnitId,
  //       request: AdRequest(),
  //       adLoadCallback: InterstitialAdLoadCallback(
  //         onAdLoaded: onAdLoaded,
  //         onAdFailedToLoad: (LoadAdError error) {
  //           print('InterstitialAd failed to load: $error');
  //         },
  //       ));
  // }

  // void onAdLoaded(InterstitialAd ad) {
  //   this._interstitialAd = ad;
  //   _isAdLoaded = true;
  //   _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
  //     onAdShowedFullScreenContent: (InterstitialAd ad) =>
  //         print('%ad onAdShowedFullScreenContent.'),
  //     onAdDismissedFullScreenContent: (InterstitialAd ad) {
  //       print('$ad onAdDismissedFullScreenContent.');
  //       ad.dispose();
  //       _submitRecord();
  //     },
  //     onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
  //       print('$ad onAdFailedToShowFullScreenContent: $error');
  //       ad.dispose();
  //     },
  //     onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
  //   );
  // }

  // void _createBannerAd() {
  //   _bannerAd = BannerAd(
  //       size: AdSize.fullBanner,
  //       adUnitId: AdMobService.bannerAdUnitId,
  //       listener: AdMobService.bannerListener,
  //       request: const AdRequest())
  //     ..load();
  // }

  void _submitRecord() async {
    final validationSuccess = _formKey.currentState!.saveAndValidate();
    if (validationSuccess) {
      setState(() {
        loading = !loading;
      });
      await DatabaseService(uid: _user!.uid).setDataAbsen(tanggal!, waktu!,
          statusKehadiran!, keperluan!, tanggalIjin!, lokasi!);
      widget.absenController!.setData(
          tanggal!, statusKehadiran!, lokasi!, keperluan!, tanggalIjin!);
      Navigator.pop(context);
    }

    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();

    // if (!CoreData().isPurchased) {
    //   _createBannerAd();
    //   _showIntertitialAd();
    // }

    waktu = DateFormat.jm().format(DateTime.now());
    tanggal =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    // infoUser = ModalRoute.of(context).settings.arguments;
    // id = infoUser['id'];
    // uid = infoUser['uid'];
    // nama = infoUser['nama'];
    // uidGroup = infoUser['uidGroup'];
    // tanggal = infoUser['tanggal'];
    // waktu = infoUser['waktu'];
    absenDone = false;
    // forUpdate = infoUser['forUpdate'];
    var tanggalView =
        DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now());
    bulan = DateFormat("MMMM", "id_ID").format(DateTime.now());
    tahun = DateFormat("yyyy", "id_ID").format(DateTime.now());

    return loading
        ? const Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(8.0),
                child: lokasi != null
                    ? ElevatedButton(
                        child: const Text(
                          'SUBMIT',
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          _submitRecord();
                        },
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            locationLoading = true;
                          });
                          await LocationService().getLocation().then((value) {
                            setState(() {
                              wilayah = value[1];
                              lokasi = wilayah;
                              locationLoading = false;
                            });
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              MyStrings.locationPinIconColor,
                              scale: 3,
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            const Text(
                              'PERBARUI LOKASI',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                              ),
                            ),
                          ],
                        ),
                      )),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_left_outlined),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      'Kehadiran Hari Ini',
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 3.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tanggalView,
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            FormBuilder(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Focus(
                                      autofocus: true,
                                      focusNode: _focusNode,
                                      canRequestFocus: true,
                                      child: FormBuilderDropdown(
                                        decoration: const InputDecoration(
                                            prefixIcon: Icon(
                                          Icons.list,
                                          color: Colors.blue,
                                        )),
                                        initialValue: absenDone!
                                            ? absenDoneOption[0]
                                            : absenOption[0],
                                        validator: absenDone!
                                            ? FormBuilderValidators.notEqual(
                                                context, absenDoneOption[0])
                                            : FormBuilderValidators.notEqual(
                                                context, absenOption[0]),
                                        name: 'absen',
                                        items: absenDone!
                                            ? absenDoneOption
                                                .map((e) => DropdownMenuItem(
                                                      value: e,
                                                      child: Text('$e'),
                                                    ))
                                                .toList()
                                            : absenOption
                                                .map((e) => DropdownMenuItem(
                                                      value: e,
                                                      child: Text('$e'),
                                                    ))
                                                .toList(),
                                        onChanged: (value) {
                                          if (value == 'WFO') {
                                            setState(() {
                                              wfo = true;
                                              statusKehadiran =
                                                  '*Work Form Office / Field* (WFO)';
                                              approval = 'Approved';
                                            });
                                          } else {
                                            setState(() {
                                              wfo = false;
                                            });
                                          }

                                          if (value == 'Sakit' ||
                                              value == 'WFH') {
                                            if (value == 'Sakit') {
                                              setState(() {
                                                sakit = true;
                                                statusKehadiran = '*Sakit*';
                                                approval = 'Waiting';
                                              });
                                            } else {
                                              setState(() {
                                                sakit = false;
                                              });
                                            }
                                          } else {
                                            setState(() {
                                              sakit = false;
                                            });
                                          }

                                          if (value == 'Ijin') {
                                            setState(() {
                                              ijin = true;
                                              statusKehadiran = 'Ijin';
                                            });
                                          } else {
                                            setState(() {
                                              ijin = false;
                                            });
                                          }

                                          if (value == 'WFH') {
                                            setState(() {
                                              wfh = true;
                                              statusKehadiran =
                                                  '*Work From Home* (WFH)';
                                            });
                                          } else {
                                            setState(() {
                                              wfh = false;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.access_time),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  '$waktu',
                                  style: const TextStyle(fontSize: 12.0),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  MyStrings.locationPinIconColor,
                                  scale: 3,
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                locationLoading
                                    ? SpinKitFadingCube(
                                        size: 17.0,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      )
                                    : lokasi != null
                                        ? Text(
                                            '$lokasi',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17.0,
                                                color: Theme.of(context)
                                                    .primaryColorDark),
                                          )
                                        : SpinKitFadingCube(
                                            size: 17.0,
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                          ),
                              ],
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  locationLoading = true;
                                });
                                //TODO: perbaiki tombol ini
                                await LocationService()
                                    .getLocation()
                                    .then((value) {
                                  setState(() {
                                    wilayah = value[1];
                                    lokasi = wilayah;
                                    locationLoading = false;
                                  });
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    MyStrings.locationPinIconColor,
                                    scale: 3,
                                  ),
                                  const SizedBox(
                                    width: 16.0,
                                  ),
                                  const Text(
                                    'PERBARUI LOKASI',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    ijin
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 8.0,
                              ),
                              const Text(
                                'Jaga kesehatan di mana pun anda berada, jangan lupa menggunakan masker & patuhi semua protokol kesehatan.',
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              const Text(
                                'Tuliskan Keperluan Ijin di Bawah Ini',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              FormBuilderTextField(
                                name: 'ijin',
                                validator:
                                    FormBuilderValidators.required(context),
                                maxLines: 2,
                                maxLength: 50,
                                onChanged: (val) {
                                  setState(() {
                                    keperluan = val!;
                                    approval = 'Waiting';
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              const Text(
                                'Pilih Tanggal Ijin',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Focus(
                                  autofocus: true,
                                  focusNode: _focusNode,
                                  canRequestFocus: true,
                                  child: FormBuilderDateRangePicker(
                                    name: 'date-picker',
                                    validator:
                                        FormBuilderValidators.required(context),
                                    firstDate: DateTime(1970),
                                    lastDate: DateTime(2030),
                                    format: DateFormat('dd-MMM-yy'),
                                    onChanged: (val) {
                                      setState(() {
                                        tanggalIjin = val.toString();
                                      });
                                    },
                                  ))
                            ],
                          )
                        : Container(),
                    // _bannerAd == null
                    //     ? Container()
                    //     : Container(
                    //         height: 52,
                    //         margin: const EdgeInsets.only(bottom: 12),
                    //         child: AdWidget(ad: _bannerAd),
                    //       )
                  ],
                ),
              ),
            ),
          );
  }
}
