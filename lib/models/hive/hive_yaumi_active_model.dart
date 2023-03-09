import 'package:hive/hive.dart';

//1. Setelah buat Model import dulu paket Hivenya
//2. Buat generated hive modelnya
part 'hive_yaumi_active_model.g.dart';

//3. Buat Hive Type dan Hive Field dengan ID unik
//4. lalu di terminal ketikan: >> flutter packages pub run build_runner build
//Untuk setiap field yang dibuat harus di generate Ulang..... AARRRGGGHHHHH!!!!
@HiveType(typeId: 1)
class HiveYaumiActiveModel extends HiveObject {
  @HiveField(0)
  bool? fardhu;

  @HiveField(1)
  bool? tahajud;

  @HiveField(2)
  bool? dhuha;

  @HiveField(3)
  bool? rawatib;

  @HiveField(4)
  bool? tilawah;

  @HiveField(5)
  bool? shaum;

  @HiveField(6)
  bool? sedekah;

  @HiveField(7)
  bool? dzikir;

  @HiveField(8)
  bool? taklim;

  @HiveField(9)
  bool? istighfar;

  @HiveField(10)
  bool? shalawat;

  @HiveField(11)
  bool? absen;
}
