import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController {
  var signUpTitle = 'DAFTAR'.obs;
  var signInTitle = 'LOGIN'.obs;
  var forgotPassTitle = 'Lupa Password?'.obs;
  var nama = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var toSignupText = 'Belum memiliki akun? '.obs;
  var toSigninText = 'Sudah memiliki akun? '.obs;

  var isLogin = true.obs;
  var isForgot = false.obs;
  var loading = false.obs;
  var isObsecure = true.obs;

  void changeAuthPage() {
    isLogin.value = !isLogin.value;
  }

  void changeObsecurity() {
    isObsecure.value = !isObsecure.value;
  }

  void changeAuthDefault() {
    isLogin.value = true;
    isForgot.value = false;
  }

  String changePageText() {
    if (isLogin.value) {
      return toSignupText.value;
    } else {
      return toSigninText.value;
    }
  }

  InputDecoration authInputDecoration() {
    return const InputDecoration();
  }
}
