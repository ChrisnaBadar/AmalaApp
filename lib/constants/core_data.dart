import 'package:intl/intl.dart';
import 'package:adhan/adhan.dart';

class CoreData {
  CoreData._();

  static String appName = 'Amala';
  static String appVersion = 'v. 1.0.0';
  static String kota = '-';
  static String wilayah = '-';
  static double lat = 6.9175;
  static double lon = 107.6191;
  static var coordinate = Coordinates(lat, lon);
  static String hariIni = DateFormat('EEEE', 'id_ID').format(DateTime.now());
  static String tanggalIni = DateFormat('dd', 'id_ID').format(DateTime.now());
  static String bulanIni = DateFormat('MMMM', 'id_ID').format(DateTime.now());
  static String tahunIni = DateFormat('yyyy', 'id_ID').format(DateTime.now());
  static String namaUser = '-';
  static const double cornerRadius = 10.0;
  static bool isTestMode = true;
}
