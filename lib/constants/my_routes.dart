import 'package:amala/pages/absen/absen_form.dart';
import 'package:amala/pages/absen/absen_page.dart';
import 'package:amala/pages/home/homepage.dart';
import 'package:amala/pages/log_absen/log_absen_page.dart';
import 'package:amala/pages/log_yaumi/log_yaumi_page.dart';
import 'package:amala/pages/print_report/yaumi_print_report_page.dart';
import 'package:amala/pages/splash_screen/splash_screen.dart';
import 'package:amala/pages/yaumi_settings/yaumi_settings_page.dart';

import '../pages/auth_page/auth_page.dart';
import '../pages/group_list/group_list_page.dart';
import '../pages/print_report/absen_print_report_page.dart';

class MyRoutes {
  final routes = {
    '/': (context) => const SplashScreen(),
    '/homepage': (context) => const Homepage(),
    '/yaumiSettings': (context) => const YaumiSettings(),
    '/absenPage': (context) => const AbsenPage(),
    '/absenForm': (context) => const AbsenForm(),
    '/logYaumi': (context) => const LogYaumiPage(),
    '/logAbsen': (context) => const LogAbsenPage(),
    '/authPage': (context) => const AuthPage(),
    '/groupListPage': (context) => const GroupListPage(),
    '/yaumiPrintReportPage': (context) => const YaumiPrintReportPage(),
    '/absenPrintReportPage': (context) => const AbsenPrintReportPage()
  };
}
