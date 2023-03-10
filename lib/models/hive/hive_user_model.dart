//1. Setelah buat Model import dulu paket Hivenya
import 'package:hive/hive.dart';

//2. Buat generated hive modelnya
part 'hive_user_model.g.dart';

//3. Buat Hive Type dan Hive Field dengan ID unik
//4. lalu di terminal ketikan: >> flutter packages pub run build_runner build
//Untuk setiap field yang dibuat harus di generate Ulang..... AARRRGGGHHHHH!!!!
@HiveType(typeId: 0)
class HiveUserModel extends HiveObject {
  @HiveField(0)
  String? uid;

  @HiveField(1)
  String? uidGroup;

  @HiveField(2)
  String? uidLeader;

  @HiveField(3)
  String? nama;

  @HiveField(4)
  String? email;

  @HiveField(5)
  String? profilePicUrl;

  @HiveField(6)
  String? group;

  @HiveField(7)
  String? lembaga;

  @HiveField(8)
  String? ponsel;

  @HiveField(9)
  String? amanah;
}
