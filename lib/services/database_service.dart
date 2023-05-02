import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../models/groups_model.dart';
import '../models/users_model.dart';

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
    String nama,
    String email,
    String profilePicUrl,
  ) async {
    await users.doc(uid).set({
      'uid': uid,
      'uidGroup': '',
      'uidLeader': '',
      'nama': nama,
      'email': email,
      'profilePicUrl': profilePicUrl,
      'group': '',
      'lembaga': '',
      'ponsel': '',
      'amanah': '',
      'yaumi': {},
      'absen': {}
    });
  }

  Future updateUserData(
    String nama,
    String email,
    String profilePicUrl,
  ) async {
    await users.doc(uid).update({
      'uid': uid,
      'nama': nama,
      'email': email,
      'profilePicUrl': profilePicUrl,
    });
  }

  //Untuk Stream USER saja
  UsersModel _userDataModelsFromSnapshot(DocumentSnapshot snapshot) {
    return UsersModel(
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

  //ini STREAM nya
  Stream<UsersModel> get userData {
    return users.doc(uid).snapshots().map(_userDataModelsFromSnapshot);
  }

// ██╗░░░██╗░█████╗░██╗░░░██╗███╗░░░███╗██╗░█████╗░██╗░░██╗
// ╚██╗░██╔╝██╔══██╗██║░░░██║████╗░████║██║██╔══██╗██║░░██║
// ░╚████╔╝░███████║██║░░░██║██╔████╔██║██║███████║███████║
// ░░╚██╔╝░░██╔══██║██║░░░██║██║╚██╔╝██║██║██╔══██║██╔══██║
// ░░░██║░░░██║░░██║╚██████╔╝██║░╚═╝░██║██║██║░░██║██║░░██║
// ░░░╚═╝░░░╚═╝░░╚═╝░╚═════╝░╚═╝░░░░░╚═╝╚═╝╚═╝░░╚═╝╚═╝░░╚═╝

  CollectionReference yaumi = FirebaseFirestore.instance.collection('users');

  Future setDataYaumi(DateTime tanggal, List yaumiList, bool isSaved,
      double point, String nama) async {
    return await yaumi.doc(uid).set({
      'yaumi': {
        DateFormat('ddMMMyy').format(tanggal): {
          'tanggal': DateFormat('EEEE, dd MMMM yyyy', "id_ID").format(tanggal),
          'date': tanggal,
          'nama': nama,
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

  UsersModel _userModelFromSnapshot(DocumentSnapshot snapshot) {
    return UsersModel(yaumi: snapshot['yaumi']);
  }

  Stream<UsersModel> get yaumiModel {
    return yaumi.doc(uid).snapshots().map(_userModelFromSnapshot);
  }

  List<UsersModel> _userListModelFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return UsersModel(yaumi: e['yaumi'], uidGroup: e['uidGroup']);
    }).toList();
  }

  Stream<List<UsersModel>> get yaumiListModel {
    return yaumi.snapshots().map(_userListModelFromSnapshot);
  }

// ░█████╗░██████╗░░██████╗███████╗███╗░░██╗░█████╗░███╗░░██╗██╗░░░░░██╗███╗░░██╗███████╗
// ██╔══██╗██╔══██╗██╔════╝██╔════╝████╗░██║██╔══██╗████╗░██║██║░░░░░██║████╗░██║██╔════╝
// ███████║██████╦╝╚█████╗░█████╗░░██╔██╗██║██║░░██║██╔██╗██║██║░░░░░██║██╔██╗██║█████╗░░
// ██╔══██║██╔══██╗░╚═══██╗██╔══╝░░██║╚████║██║░░██║██║╚████║██║░░░░░██║██║╚████║██╔══╝░░
// ██║░░██║██████╦╝██████╔╝███████╗██║░╚███║╚█████╔╝██║░╚███║███████╗██║██║░╚███║███████╗
// ╚═╝░░╚═╝╚═════╝░╚═════╝░╚══════╝╚═╝░░╚══╝░╚════╝░╚═╝░░╚══╝╚══════╝╚═╝╚═╝░░╚══╝╚══════╝

  CollectionReference absen = FirebaseFirestore.instance.collection('users');

  Future setDataAbsen(
      DateTime tanggal,
      String waktu,
      String nama,
      String kehadiran,
      String keperluan,
      String tanggalIjin,
      String lokasi) async {
    return await absen.doc(uid).set({
      'absen': {
        DateFormat('ddMMMyy').format(tanggal): {
          'tanggal': DateFormat('EEEE, dd MMMM yyyy', "id_ID").format(tanggal),
          'date': tanggal,
          'nama': nama,
          'waktu': waktu,
          'kehadiran': kehadiran,
          'keperluan': keperluan,
          'tanggalIjin': tanggalIjin,
          'lokasi': lokasi
        }
      }
    }, SetOptions(merge: true));
  }

  //Delete Absen
  Future deleteDataAbsen(String tanggal) async {
    await absen.doc(uid).update({'absen.$tanggal': FieldValue.delete()});
  }

  UsersModel _userAbsenModelFromSnapshot(DocumentSnapshot snapshot) {
    return UsersModel(absen: snapshot['absen']);
  }

  Stream<UsersModel> get absenModel {
    return absen.doc(uid).snapshots().map(_userAbsenModelFromSnapshot);
  }

// ░██████╗░██████╗░░█████╗░██╗░░░██╗██████╗░
// ██╔════╝░██╔══██╗██╔══██╗██║░░░██║██╔══██╗
// ██║░░██╗░██████╔╝██║░░██║██║░░░██║██████╔╝
// ██║░░╚██╗██╔══██╗██║░░██║██║░░░██║██╔═══╝░
// ╚██████╔╝██║░░██║╚█████╔╝╚██████╔╝██║░░░░░
// ░╚═════╝░╚═╝░░╚═╝░╚════╝░░╚═════╝░╚═╝░░░░░

  CollectionReference group = FirebaseFirestore.instance.collection('groups');

  Future setGroupData(
      String nama, String photoUrl, String namaGroup, String groupIcon) async {
    await group.doc(uid).set({
      'uidGroup': uid,
      'uidLeader': uid,
      'namaGroup': namaGroup,
      'groupIcon': groupIcon,
      'member': {
        uid: {'nama': nama, 'photoUrl': photoUrl, 'uid': uid}
      }
    });
    await users.doc(uid).update({
      'uidGroup': uid,
      'uidLeader': uid,
      'group': namaGroup,
    });
  }

  Future joinGroup(String nama, String photoUrl, String namaGroup) async {
    await group.doc(uidLeader).set({
      'member': {
        uid: {'nama': nama, 'photoUrl': photoUrl, 'uid': uid}
      }
    }, SetOptions(merge: true));
    await users.doc(uid).update(
        {'uidLeader': uidLeader, 'uidGroup': uidLeader, 'group': namaGroup});
  }

  Future unjoinGroup() async {
    await group.doc(uidLeader).update({'member.$uid': FieldValue.delete()});
    await users.doc(uid).update({'uidLeader': '', 'uidGroup': '', 'group': ''});
  }

  Future removeGroupData() async {
    return await group
        .doc(uidLeader)
        .update({'member.$uid': FieldValue.delete()});
  }

  Future removeGroup() async {
    await group.doc(uidLeader).delete();
    await users.doc(uid).update({'uidGroup': '', 'uidLeader': '', 'group': ''});
    return true;
  }

  GroupsModel _groupModelFromSnapshot(DocumentSnapshot snapshot) {
    return GroupsModel(
        uidGroup: snapshot['uidGroup'],
        uidLeader: snapshot['uidLeader'],
        namaGroup: snapshot['namaGroup'],
        groupIcon: snapshot['groupIcon'],
        member: snapshot['member']);
  }

  Stream<GroupsModel> get groupModel {
    return group.doc(uidGroup).snapshots().map(_groupModelFromSnapshot);
  }

  List<GroupsModel> _groupModelListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return GroupsModel(
          uidGroup: e['uidGroup'],
          uidLeader: e['uidLeader'],
          namaGroup: e['namaGroup'],
          groupIcon: e['groupIcon'],
          member: e['member']);
    }).toList();
  }

  Stream<List<GroupsModel>> get groupModelList {
    return group.snapshots().map(_groupModelListFromSnapshot);
  }
}
