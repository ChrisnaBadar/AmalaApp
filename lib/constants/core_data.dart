import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';

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
  static bool isTestMode = false;
  static int locationFetchDuration = 20;

  //identity
  static String? uid = '-';
  static String? nama = '-';
  static String? lembaga = '-';
  static String? amanah = '-';
  static String? group = '-';
  static String? email = '-';
  static String? ponsel = '-';
  static String? password = '-';
  static String? uidGroup = '-';
  static String? uidLeader = '-';
  static String? profilePicUrl = '-';

  static List<String> testDeviceIds = ['FACCB5E8557A3F11B0E7632F91836CDF'];

  //absen
  static List list = [
    'Work From Office / Field (WFO)',
    'Ijin',
    'Sakit',
    'Work From Home (WFH)'
  ];

  //adhan
  static String shalatTitle = '';
  static String shalatTimes = '';
  static int levelClock = 0;
}
