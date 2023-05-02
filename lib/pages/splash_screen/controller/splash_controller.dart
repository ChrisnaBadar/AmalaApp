import 'package:amala/blocs/bloc_exports.dart';
import 'package:amala/constants/core_data.dart';
import 'package:amala/services/location_service.dart';
import 'package:flutter/material.dart';

class SplashController {
  void locationFetch(BuildContext context) async {
    await LocationService().getLocation();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/homepage');
  }
}
