import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../services/admob_service.dart';
import '../loading/loading.dart';
import '../splash/splash_screen.dart';
import 'EditProfileScreen/edit_profile_screen.dart';
import 'controller/user_page_controller.dart';

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
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
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
                      Get.off(() => const SplashScreen());
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
                                  const SizedBox(
                                    height: 50.0,
                                  ),
                                  CircleAvatar(
                                    radius: 75.0,
                                    child: CircleAvatar(
                                      radius: 72.5,
                                      backgroundColor: Colors.amber,
                                      backgroundImage: _user!.photoURL == null
                                          ? null
                                          : NetworkImage(_user!.photoURL!),
                                      child: _user!.photoURL == null
                                          ? const Icon(Icons.person)
                                          : null,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Column(
                                    children: [
                                      Text('${_user!.displayName}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold)),
                                      TextButton(
                                          onPressed: () {
                                            Get.to(() =>
                                                const EditProfileScreen());
                                          },
                                          child: const Text('Edit Profile')),
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
                                        const Text('Group / Komunitas: ',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold)),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Card(
                                            child: ListTile(
                                              leading: const CircleAvatar(
                                                radius: 20.0,
                                                child: CircleAvatar(
                                                  radius: 17.5,
                                                  backgroundColor: Colors.amber,
                                                  child: Icon(Icons.group),
                                                ),
                                              ),
                                              title: const Text('Group Info',
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
                                                  icon:
                                                      const Icon(Icons.group)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),

                                    //lembaga
                                    const Section2Widget(
                                      title: 'Lembaga',
                                      lembaga: 'lembaga',
                                    ),

                                    //amanah
                                    const Section2Widget(
                                      title: 'Amanah',
                                      amanah: 'amanah',
                                    ),

                                    //email
                                    const Section2Widget(
                                      title: 'Email',
                                      email: 'email',
                                    ),

                                    const Section2Widget(
                                      title: 'Ponsel',
                                      ponsel: 'ponsel',
                                    ),

                                    //logout
                                    Row(
                                      children: const [
                                        //TODO: Logout??
                                      ],
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
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.bold)),
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
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ],
      ),
    );
  }
}
