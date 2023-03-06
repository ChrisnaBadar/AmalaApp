import 'package:hive/hive.dart';

//1. Setelah buat Model import dulu paket Hivenya
//2. Buat generated hive modelnya
part 'hive_yaumi_model.g.dart';

//3. Buat Hive Type dan Hive Field dengan ID unik
//4. lalu di terminal ketikan: >> flutter packages pub run build_runner build
//Untuk setiap field yang dibuat harus di generate Ulang..... AARRRGGGHHHHH!!!!
@HiveType(typeId: 2)
class HiveYaumiModel extends HiveObject {
  @HiveField(0)
  DateTime? tanggal;

  @HiveField(1)
  bool? shubuh;

  @HiveField(2)
  bool? dhuhur;

  @HiveField(3)
  bool? ashar;

  @HiveField(4)
  bool? maghrib;

  @HiveField(5)
  bool? isya;

  @HiveField(6)
  bool? tahajud;

  @HiveField(7)
  bool? dhuha;

  @HiveField(8)
  bool? rawatib;

  @HiveField(9)
  bool? tilawah;

  @HiveField(10)
  bool? shaum;

  @HiveField(11)
  bool? sedekah;

  @HiveField(12)
  bool? dzikirPagi;

  @HiveField(13)
  bool? dzikirPetang;

  @HiveField(14)
  bool? taklim;

  @HiveField(15)
  bool? istighfar;

  @HiveField(16)
  bool? shalawat;

  @HiveField(17)
  bool? isSaved;

  @HiveField(18)
  double? point;
}
