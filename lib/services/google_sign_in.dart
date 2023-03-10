import 'package:amala/constants/core_data.dart';
import 'package:amala/models/hive/hive_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/hive/boxes.dart';
import '../pages/splash/splash_screen.dart';
import 'database_service.dart';

/// Untuk komputer baru haru tambahkan fingerprint baru di project settings firebase
/// dengan cara
/// ketik di terminal
/// keytool -list -v -keystore %USERPROFILE%\.android\debug.keystore -alias androiddebugkey -storepass android -keypass android
///
/// APP CONSENT
/// App name from: project-1049962924182 to : Yaumi

class GoogleSingInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogIn(bool userExist) async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);
    final User? currentUser = FirebaseAuth.instance.currentUser;

    notifyListeners();

    if (!userExist) {
      await setFirstUserData(currentUser!);
    }

    Get.offAll(() => const SplashScreen());
  }

  Future setFirstUserData(User currentUser) async {
    await DatabaseService(uid: currentUser.uid).setUserData(
        '-',
        '-',
        currentUser.displayName!,
        currentUser.email!,
        '-',
        '-',
        '-',
        currentUser.phoneNumber ?? '-',
        '-');
    final userHiveModel = HiveUserModel()
      ..uid = currentUser.uid
      ..uidGroup = CoreData.uidGroup
      ..uidLeader = CoreData.uidLeader
      ..nama = currentUser.displayName
      ..email = currentUser.email
      ..password = CoreData.password
      ..group = CoreData.group
      ..lembaga = CoreData.lembaga
      ..ponsel = currentUser.phoneNumber ?? '-'
      ..amanah = CoreData.amanah;

    final box = Boxes.getUserModel();
    box.put('user', userHiveModel);
  }
}
