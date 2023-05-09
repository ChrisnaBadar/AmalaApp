import 'package:amala/services/location_service.dart';
import 'package:flutter/material.dart';

class SplashController {
  void locationFetch(BuildContext context) async {
    await LocationService().getLocation();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/homepage');
  }
}
