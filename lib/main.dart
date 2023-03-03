import 'package:amala/home/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting('id_ID', null)
      .then((value) => runApp(const Amala()));
}

class Amala extends StatelessWidget {
  const Amala({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Amala',
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
