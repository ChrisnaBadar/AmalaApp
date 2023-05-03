import 'package:amala/blocs/bloc_exports.dart';
import 'package:amala/blocs/user_bloc/user_bloc.dart';
import 'package:amala/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Untuk komputer baru haru tambahkan fingerprint baru di project settings firebase
/// dengan cara
/// ketik di terminal
/// keytool -list -v -keystore %USERPROFILE%\.android\debug.keystore -alias androiddebugkey -storepass android -keypass android
///
/// APP CONSENT
/// App name from: project-1049962924182 to : Yaumi
///
/// YANG DILAKUKAN SAAT SIGN IN:
/// 1. CATAT DATA CREDENTIAL KE HYDRATED STORAGE
/// 2. CATAT DATA KE AMALA FIRESTORE (DATA AWAL DENGAN SET. UNTUK PENGGUNA BARU DAN UPDATE. UNTUK PENGGUNA LAMA) => GUNAKAN METODE TRY - CATCH
///
///

class GoogleSingInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogIn(BuildContext context) async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);
      final currentUser = FirebaseAuth.instance.currentUser;
      try {
        await DatabaseService(uid: currentUser!.uid).updateUserData(
            currentUser.displayName!,
            currentUser.email!,
            currentUser.photoURL!);
      } catch (e) {
        await DatabaseService(uid: currentUser!.uid).setUserData(
            currentUser.displayName!,
            currentUser.email!,
            currentUser.photoURL!);
      }
      // ignore: use_build_context_synchronously
      context.read<UserBloc>().add(SetUserDatabase(currentUser.uid,
          currentUser.displayName!, currentUser.email!, currentUser.photoURL!));

      notifyListeners();

      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/');
    } catch (e) {
      return;
    }
  }
}
