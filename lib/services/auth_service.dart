import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Sign out
  Future signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
