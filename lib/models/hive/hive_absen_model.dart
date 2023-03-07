import 'package:hive/hive.dart';

//1. Setelah buat Model import dulu paket Hivenya
//2. Buat generated hive modelnya
part 'hive_absen_model.g.dart';

//3. Buat Hive Type dan Hive Field dengan ID unik
//4. lalu di terminal ketikan: >> flutter packages pub run build_runner build
//Untuk setiap field yang dibuat harus di generate Ulang..... AARRRGGGHHHHH!!!!

@HiveType(typeId: 3)
class HiveAbsenModel extends HiveObject {
  @HiveField(0)
  DateTime? date;
  @HiveField(1)
  String? tanggal;
  @HiveField(2)
  String? waktu;
  @HiveField(3)
  String? kehadiran;
  @HiveField(4)
  String? keperluan;
  @HiveField(5)
  String? tanggalIjin;
  @HiveField(6)
  String? lokasi;
}
