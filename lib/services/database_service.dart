import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:amala/models/user_model.dart';

import '../models/group_model.dart';

class DatabaseService {
  final String? uid;
  final String? uidGroup;
  final String? uidLeader;
  final String? uidTanggal;
  final String? tanggal;
  final String? bulan;
  final String? tahun;
  final String? bulanTahun;
  final String? idDonasi;
  final String? tugasId;

  DatabaseService(
      {this.uid,
      this.uidGroup,
      this.uidLeader,
      this.uidTanggal,
      this.tanggal,
      this.bulan,
      this.tahun,
      this.bulanTahun,
      this.idDonasi,
      this.tugasId});

// ██╗░░░██╗░██████╗███████╗██████╗░  ██████╗░░█████╗░████████╗░█████╗░
// ██║░░░██║██╔════╝██╔════╝██╔══██╗  ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗
// ██║░░░██║╚█████╗░█████╗░░██████╔╝  ██║░░██║███████║░░░██║░░░███████║
// ██║░░░██║░╚═══██╗██╔══╝░░██╔══██╗  ██║░░██║██╔══██║░░░██║░░░██╔══██║
// ╚██████╔╝██████╔╝███████╗██║░░██║  ██████╔╝██║░░██║░░░██║░░░██║░░██║
// ░╚═════╝░╚═════╝░╚══════╝╚═╝░░╚═╝  ╚═════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future setUserData(
    String uidGroup,
    String uidLeader,
    String nama,
    String email,
    String profilePicUrl,
    String group,
    String lembaga,
    String ponsel,
    String amanah,
  ) async {
    await users.doc(uid).set({
      'uid': uid,
      'uidGroup': uidGroup,
      'uidLeader': uidLeader,
      'nama': nama,
      'email': email,
      'profilePicUrl': profilePicUrl,
      'group': group,
      'lembaga': lembaga,
      'ponsel': ponsel,
      'amanah': amanah
    });
  }

  //Metoda update data user saat Edit profile di userEdit
  Future updateUserData(String lembaga, String amanah) async {
    return await yaumi.doc(uid).update({'lembaga': lembaga, 'amanah': amanah});
  }

  //Metoda update data user saat Edit profile di userEdit
  Future updateUserData1(
      String uidGroup, String uidLeader, String group) async {
    return await yaumi
        .doc(uid)
        .update({'uidGroup': uidGroup, 'uidLeader': uidLeader, 'group': group});
  }

  //Untuk Stream USER saja
  UserModels _userDataModelsFromSnapshot(DocumentSnapshot snapshot) {
    return UserModels(
        uid: snapshot['uid'] ?? '',
        uidGroup: snapshot['uidGroup'] ?? '',
        uidLeader: snapshot['uidLeader'] ?? '',
        nama: snapshot['nama'] ?? '',
        email: snapshot['email'] ?? '',
        profilePicUrl: snapshot['profilePicUrl'] ?? '',
        group: snapshot['group'] ?? '',
        lembaga: snapshot['lembaga'] ?? '',
        ponsel: snapshot['ponsel'] ?? '',
        amanah: snapshot['amanah'] ?? '',
        yaumi: snapshot['yaumi'] ?? '',
        absen: snapshot['absen'] ?? '');
  }

  // ini STREAM nya
  Stream<UserModels> get userData {
    return users.doc(uid).snapshots().map(_userDataModelsFromSnapshot);
  }

// ██╗░░░██╗░█████╗░██╗░░░██╗███╗░░░███╗██╗░█████╗░██╗░░██╗
// ╚██╗░██╔╝██╔══██╗██║░░░██║████╗░████║██║██╔══██╗██║░░██║
// ░╚████╔╝░███████║██║░░░██║██╔████╔██║██║███████║███████║
// ░░╚██╔╝░░██╔══██║██║░░░██║██║╚██╔╝██║██║██╔══██║██╔══██║
// ░░░██║░░░██║░░██║╚██████╔╝██║░╚═╝░██║██║██║░░██║██║░░██║
// ░░░╚═╝░░░╚═╝░░╚═╝░╚═════╝░╚═╝░░░░░╚═╝╚═╝╚═╝░░╚═╝╚═╝░░╚═╝

  CollectionReference yaumi = FirebaseFirestore.instance.collection('users');

  Future setDataYaumi(
      DateTime tanggal, List yaumiList, bool isSaved, double point) async {
    return await yaumi.doc(uid).set({
      'yaumi': {
        DateFormat('ddMMMyy').format(tanggal): {
          'tanggal': DateFormat('EEEE, dd MMMM yyyy', "id_ID").format(tanggal),
          'date': tanggal,
          'shubuh': yaumiList[0],
          'dhuhur': yaumiList[1],
          'ashar': yaumiList[2],
          'maghrib': yaumiList[3],
          'isya': yaumiList[4],
          'tahajud': yaumiList[5],
          'dhuha': yaumiList[6],
          'rawatib': yaumiList[7],
          'tilawah': yaumiList[8],
          'shaum': yaumiList[9],
          'sedekah': yaumiList[10],
          'dzikirPagi': yaumiList[11],
          'dzikirPetang': yaumiList[12],
          'taklim': yaumiList[13],
          'istighfar': yaumiList[14],
          'shalawat': yaumiList[15],
          'isSaved': isSaved,
          'point': point
        }
      }
    }, SetOptions(merge: true));
  }

  Future updateDataYaumi(
      DateTime tanggal, List yaumiList, bool isSaved, double point) async {
    return await yaumi.doc(uid).update({
      'yaumi.${DateFormat('ddMMMyy').format(tanggal)}.tanggal':
          DateFormat('EEEE, dd MMMM yyyy', "id_ID").format(tanggal),
      'yaumi.${DateFormat('ddMMMyy').format(tanggal)}.date': tanggal,
      'yaumi.${DateFormat('ddMMMyy').format(tanggal)}.shubuh': yaumiList[0],
      'yaumi.${DateFormat('ddMMMyy').format(tanggal)}.dhuhur': yaumiList[1],
      'yaumi.${DateFormat('ddMMMyy').format(tanggal)}.ashar': yaumiList[2],
      'yaumi.${DateFormat('ddMMMyy').format(tanggal)}.maghrib': yaumiList[3],
      'yaumi.${DateFormat('ddMMMyy').format(tanggal)}.isya': yaumiList[4],
      'yaumi.${DateFormat('ddMMMyy').format(tanggal)}.tahajud': yaumiList[5],
      'yaumi.${DateFormat('ddMMMyy').format(tanggal)}.dhuha': yaumiList[6],
      'yaumi.${DateFormat('ddMMMyy').format(tanggal)}.rawatib': yaumiList[7],
      'yaumi.${DateFormat('ddMMMyy').format(tanggal)}.tilawah': yaumiList[8],
      'yaumi.${DateFormat('ddMMMyy').format(tanggal)}.shaum': yaumiList[9],
      'yaumi.${DateFormat('ddMMMyy').format(tanggal)}.sedekah': yaumiList[10],
      'yaumi.${DateFormat('ddMMMyy').format(tanggal)}.dzikirPagi':
          yaumiList[11],
      'yaumi.${DateFormat('ddMMMyy').format(tanggal)}.dzikirPetang':
          yaumiList[12],
      'yaumi.${DateFormat('ddMMMyy').format(tanggal)}.taklim': yaumiList[13],
      'yaumi.${DateFormat('ddMMMyy').format(tanggal)}.istighfar': yaumiList[14],
      'yaumi.${DateFormat('ddMMMyy').format(tanggal)}.shalawat': yaumiList[15],
      'yaumi.${DateFormat('ddMMMyy').format(tanggal)}.isSaved': isSaved,
      'yaumi.${DateFormat('ddMMMyy').format(tanggal)}.point': point
    });
  }

  UserModels _userModelFromSnapshot(DocumentSnapshot snapshot) {
    return UserModels(yaumi: snapshot['yaumi']);
  }

  Stream<UserModels> get yaumiModel {
    return yaumi.doc(uid).snapshots().map(_userModelFromSnapshot);
  }

// ░█████╗░██████╗░░██████╗███████╗███╗░░██╗░█████╗░███╗░░██╗██╗░░░░░██╗███╗░░██╗███████╗
// ██╔══██╗██╔══██╗██╔════╝██╔════╝████╗░██║██╔══██╗████╗░██║██║░░░░░██║████╗░██║██╔════╝
// ███████║██████╦╝╚█████╗░█████╗░░██╔██╗██║██║░░██║██╔██╗██║██║░░░░░██║██╔██╗██║█████╗░░
// ██╔══██║██╔══██╗░╚═══██╗██╔══╝░░██║╚████║██║░░██║██║╚████║██║░░░░░██║██║╚████║██╔══╝░░
// ██║░░██║██████╦╝██████╔╝███████╗██║░╚███║╚█████╔╝██║░╚███║███████╗██║██║░╚███║███████╗
// ╚═╝░░╚═╝╚═════╝░╚═════╝░╚══════╝╚═╝░░╚══╝░╚════╝░╚═╝░░╚══╝╚══════╝╚═╝╚═╝░░╚══╝╚══════╝

  CollectionReference absen = FirebaseFirestore.instance.collection('users');

  Future setDataAbsen(DateTime tanggal, String waktu, String kehadiran,
      String keperluan, String tanggalIjin, String lokasi) async {
    return await absen.doc(uid).set({
      'absen': {
        DateFormat('ddMMMyy').format(tanggal): {
          'tanggal': DateFormat('EEEE, dd MMMM yyyy', "id_ID").format(tanggal),
          'date': tanggal,
          'waktu': waktu,
          'kehadiran': kehadiran,
          'keperluan': keperluan,
          'tanggalIjin': tanggalIjin,
          'lokasi': lokasi
        }
      }
    }, SetOptions(merge: true));
  }

// ░██████╗░██████╗░░█████╗░██╗░░░██╗██████╗░
// ██╔════╝░██╔══██╗██╔══██╗██║░░░██║██╔══██╗
// ██║░░██╗░██████╔╝██║░░██║██║░░░██║██████╔╝
// ██║░░╚██╗██╔══██╗██║░░██║██║░░░██║██╔═══╝░
// ╚██████╔╝██║░░██║╚█████╔╝╚██████╔╝██║░░░░░
// ░╚═════╝░╚═╝░░╚═╝░╚════╝░░╚═════╝░╚═╝░░░░░

  CollectionReference group = FirebaseFirestore.instance.collection('groups');

  Future setGroupData(
      {String? uidGroup,
      String? uidLeader,
      String? namaGroup,
      String? groupIcon,
      List? member}) async {
    return await group.doc(uid).set({
      'uidGroup': uidGroup,
      'uidLeader': uidLeader,
      'namaGroup': namaGroup,
      'groupIcon': groupIcon,
      'member': member
    });
  }

  Future updateGroupData({List? member}) async {
    return await group.doc(uid).update({
      'member': FieldValue.arrayUnion([member])
    });
  }

  GroupModel _groupModelFromSnapshot(DocumentSnapshot snapshot) {
    return GroupModel(
        uidGroup: snapshot['uidGroup'],
        uidLeader: snapshot['uidLeader'],
        namaGroup: snapshot['namaGroup'],
        groupIcon: snapshot['groupIcon'],
        member: snapshot['member']);
  }

  Stream<GroupModel> get groupModel {
    return group.doc(uidGroup).snapshots().map(_groupModelFromSnapshot);
  }

  List<GroupModel> _groupModelListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return GroupModel(
          uidGroup: e['uidGroup'],
          uidLeader: e['uidLeader'],
          namaGroup: e['namaGroup'],
          groupIcon: e['groupIcon'],
          member: e['member']);
    }).toList();
  }

  Stream<List<GroupModel>> get groupModelList {
    return group.snapshots().map(_groupModelListFromSnapshot);
  }
}
