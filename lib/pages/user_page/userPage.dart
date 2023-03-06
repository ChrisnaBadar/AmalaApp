import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../services/admob_service.dart';
import '../loading/Loading.dart';
import '../splash/splash_screen.dart';
import 'controller/userPageController.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  BannerAd? _bannerAd;

  final userPageController = Get.put(UserPageController());

  final User? _user = FirebaseAuth.instance.currentUser;

  void _createBannerAd() {
    _bannerAd = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: AdMobService.bannerAdUnitId,
        listener: AdMobService.bannerListener,
        request: const AdRequest())
      ..load();
  }

  @override
  void initState() {
    super.initState();
    // if (!CoreData().isPurchased) {
    //   _createBannerAd();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        child: userPageController.loading.value
            ? const Loading()
            : Scaffold(
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'LOGOUT',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.5),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        userPageController.loading.value = true;
                      });

                      //await AuthService().signOut();
                      Get.off(() => SplashScreen());
                    },
                  ),
                ),
                body: CustomScrollView(slivers: [
                  SliverFillRemaining(
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            //Section 1
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 50.0,
                                  ),
                                  CircleAvatar(
                                    radius: 75.0,
                                    child: CircleAvatar(
                                      radius: 72.5,
                                      backgroundColor: Colors.amber,
                                      child: _user!.photoURL == null
                                          ? Icon(Icons.person)
                                          : null,
                                      backgroundImage: _user!.photoURL == null
                                          ? null
                                          : NetworkImage(_user!.photoURL!),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Column(
                                    children: [
                                      Text('${_user!.displayName}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold)),
                                      TextButton(
                                          onPressed: () {
                                            // Get.to(() => EditProfileScreen(),
                                            //     arguments: {
                                            //       'uid': uid,
                                            //       'nama': nama,
                                            //       'lembaga': lembaga,
                                            //       'amanah': amanah,
                                            //       'group': group,
                                            //       'email': email,
                                            //       'ponsel': ponsel,
                                            //       'password': password,
                                            //       'uidGroup': uidGroup,
                                            //       'uidLeader': uidLeader
                                            //     });
                                          },
                                          child: Text('Edit Profile')),
                                    ],
                                  ),
                                  _bannerAd == null
                                      ? Container()
                                      : Container(
                                          height: 52,
                                          margin:
                                              const EdgeInsets.only(bottom: 12),
                                          child: AdWidget(ad: _bannerAd!),
                                        )
                                ],
                              ),
                            ),

                            //Section 2
                            Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //group
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Group / Komunitas: ',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold)),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Card(
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                radius: 20.0,
                                                child: CircleAvatar(
                                                  radius: 17.5,
                                                  backgroundColor: Colors.amber,
                                                  child: Icon(Icons.group),
                                                ),
                                              ),
                                              title: Text('Group Info',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 12.0)),
                                              trailing: IconButton(
                                                  onPressed: () {
                                                    // if (group == '-') {
                                                    //   Get.to(() => GroupPage());
                                                    // } else {
                                                    //   Get.to(
                                                    //       () => GroupDetails(),
                                                    //       arguments: {
                                                    //         'uidLeader':
                                                    //             uidLeader,
                                                    //         'uidGroup':
                                                    //             uidGroup,
                                                    //         'uid': uid
                                                    //       });
                                                    // }
                                                  },
                                                  icon: Icon(Icons.group)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),

                                    //lembaga
                                    Section2Widget(
                                      title: 'Lembaga',
                                      lembaga: 'lembaga',
                                    ),

                                    //amanah
                                    Section2Widget(
                                      title: 'Amanah',
                                      amanah: 'amanah',
                                    ),

                                    //email
                                    Section2Widget(
                                      title: 'Email',
                                      email: 'email',
                                    ),

                                    Section2Widget(
                                      title: 'Ponsel',
                                      ponsel: 'ponsel',
                                    ),

                                    //logout
                                    Row(
                                      children: [],
                                    ),
                                  ],
                                )),

                            //Section 3
                          ],
                        ),
                      ),
                    ),
                  )
                ]),
              ),
      ),
    );
  }
}

class Section2Widget extends StatelessWidget {
  const Section2Widget({
    Key? key,
    this.lembaga,
    this.amanah,
    this.email,
    this.title,
    this.ponsel,
  }) : super(key: key);

  final String? lembaga, amanah, email, title, ponsel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text('$title',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 3,
            child: Text(
                title == 'Lembaga'
                    ? ': $lembaga'
                    : title == 'Amanah'
                        ? ': $amanah'
                        : title == 'Email'
                            ? ': $email'
                            : ': $ponsel',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ],
      ),
    );
  }
}
