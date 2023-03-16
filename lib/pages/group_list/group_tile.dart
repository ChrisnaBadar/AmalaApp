import 'dart:math';

import 'package:amala/constants/my_strings.dart';
import 'package:amala/models/group_model.dart';
import 'package:amala/models/hive/hive_user_model.dart';
import 'package:amala/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../constants/core_data.dart';
import '../../models/hive/boxes.dart';
import '../loading/loading.dart';

class GroupTile extends StatefulWidget {
  final GroupModel? groupModel;
  const GroupTile({super.key, this.groupModel});

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final members = widget.groupModel!.member!.values.toList();
    return Card(
      child: ListTile(
        trailing: CircleAvatar(
          radius: 25.0,
          child: Image.asset(
            widget.groupModel!.groupIcon!,
            scale: 1,
          ),
        ),
        title: Text(
          widget.groupModel!.namaGroup!,
          style: TextStyle(
              fontSize: 17.5,
              color: Colors.blueGrey[700],
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jumlah Anggota:',
              style: TextStyle(color: Colors.cyan[800]),
            ),
            Text('${widget.groupModel!.member!.length} Orang')
          ],
        ),
        isThreeLine: true,
        onTap: () => showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
          builder: (context) => _buildSheet(widget.groupModel!, members),
        ),
      ),
    );
  }

  Widget _buildSheet(GroupModel groupModel, List members) {
    final isNotMember =
        members.where((e) => e['uid'] == currentUser!.uid).isEmpty;
    final isGroupLeader = groupModel.uidLeader == currentUser!.uid;
    return loading
        ? const Loading()
        : ValueListenableBuilder<Box<HiveUserModel>>(
            valueListenable: Boxes.getUserModel().listenable(),
            builder: (context, box, _) {
              final hiveUserModel = box.values.toList().cast<HiveUserModel>();
              if (hiveUserModel.isNotEmpty) {
                final _result = hiveUserModel.where((element) =>
                    element.uidGroup == 'DmEAhN5MuSgX9Ny5Lr1MnQxs0862');
                debugPrint('$_result');
                return SizedBox(
                  height: 300.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          width: 75.0,
                          height: 3.0,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              groupModel.namaGroup!,
                              style: const TextStyle(
                                  fontSize: 17.5, fontWeight: FontWeight.bold),
                            )),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Jumlah Anggota: ${groupModel.member!.length}',
                          style: const TextStyle(color: Colors.green),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1.0,
                        color: Colors.blueGrey[300],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Member:',
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 80.0,
                        child: ListView.builder(
                          itemCount: members.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    members[index]['photoUrl'],
                                    scale: 2),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              SizedBox(
                                width: 70.0,
                                child: Text(
                                  members[index]['nama'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 10.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      CoreData.uidGroup == '-'
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      loading = true;
                                    });
                                    try {
                                      //write userModel for online db
                                      await DatabaseService(
                                              uidLeader:
                                                  widget.groupModel!.uidLeader,
                                              uid: currentUser!.uid)
                                          .updateGroupData(
                                              nama: currentUser!.displayName,
                                              photoUrl: currentUser!.photoURL);

                                      await DatabaseService(
                                              uid: currentUser!.uid)
                                          .updateUserData1(
                                              widget.groupModel!.uidGroup!,
                                              widget.groupModel!.uidLeader!,
                                              widget.groupModel!.namaGroup!);
                                      //write hiveModel for local db
                                      final hiveUserModel = HiveUserModel()
                                        ..uid = currentUser!.uid
                                        ..uidGroup =
                                            widget.groupModel!.uidLeader
                                        ..uidLeader =
                                            widget.groupModel!.uidLeader
                                        ..nama = currentUser!.displayName
                                        ..email = currentUser!.email
                                        ..profilePicUrl = currentUser!.photoURL
                                        ..group = widget.groupModel!.namaGroup
                                        ..lembaga = CoreData.lembaga
                                        ..ponsel = currentUser!.phoneNumber
                                        ..amanah = CoreData.amanah;

                                      final box = Boxes.getUserModel();
                                      box.put('user', hiveUserModel);

                                      //core data
                                      CoreData.uidGroup =
                                          widget.groupModel!.uidGroup;
                                      CoreData.uidLeader =
                                          widget.groupModel!.uidLeader;
                                      CoreData.group =
                                          widget.groupModel!.namaGroup;

                                      setState(() {
                                        loading = false;
                                      });

                                      //back
                                      Get.back();
                                    } catch (e) {
                                      debugPrint('gagal with $e');
                                      setState(() {
                                        loading = false;
                                      });
                                      //back
                                      Get.back();
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width * .8,
                                    child: const Text('Gabung Group'),
                                  )),
                            )
                          : isGroupLeader
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          loading = true;
                                        });
                                        try {
                                          //remove userModel for online db
                                          await DatabaseService(
                                                  uidLeader: widget
                                                      .groupModel!.uidLeader)
                                              .removeGroup();

                                          await DatabaseService(
                                                  uid: currentUser!.uid)
                                              .updateUserData1('-', '-', '-');
                                          //write hiveModel for local db
                                          final hiveUserModel = HiveUserModel()
                                            ..uid = currentUser!.uid
                                            ..uidGroup = '-'
                                            ..uidLeader = '-'
                                            ..nama = currentUser!.displayName
                                            ..email = currentUser!.email
                                            ..profilePicUrl =
                                                currentUser!.photoURL
                                            ..group = '-'
                                            ..lembaga = CoreData.lembaga
                                            ..ponsel = currentUser!.phoneNumber
                                            ..amanah = CoreData.amanah;

                                          final box = Boxes.getUserModel();
                                          box.put('user', hiveUserModel);

                                          setState(() {
                                            loading = false;
                                          });

                                          //back
                                          Get.back();
                                        } catch (e) {
                                          setState(() {
                                            loading = false;
                                          });
                                          //back
                                          Get.back();
                                        }
                                      },
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll<Color>(
                                                  Colors.red)),
                                      child: Container(
                                        alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .8,
                                        child: const Text('Hapus Group'),
                                      )),
                                )
                              : isNotMember
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                          onPressed: null,
                                          style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll<
                                                      Color>(Colors.blueGrey)),
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .8,
                                            child: const Text(
                                              'Not Your Group',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )),
                                    )
                                  : Container(
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            setState(() {
                                              loading = true;
                                            });
                                            try {
                                              //remove userModel for online db
                                              await DatabaseService(
                                                      uidLeader: widget
                                                          .groupModel!
                                                          .uidLeader,
                                                      uid: currentUser!.uid)
                                                  .removeGroupData();

                                              await DatabaseService(
                                                      uid: currentUser!.uid)
                                                  .updateUserData1(
                                                      '-', '-', '-');
                                              //write hiveModel for local db
                                              final hiveUserModel =
                                                  HiveUserModel()
                                                    ..uid = currentUser!.uid
                                                    ..uidGroup = '-'
                                                    ..uidLeader = '-'
                                                    ..nama =
                                                        currentUser!.displayName
                                                    ..email = currentUser!.email
                                                    ..profilePicUrl =
                                                        currentUser!.photoURL
                                                    ..group = widget
                                                        .groupModel!.namaGroup
                                                    ..lembaga = CoreData.lembaga
                                                    ..ponsel =
                                                        currentUser!.phoneNumber
                                                    ..amanah = CoreData.amanah;

                                              final box = Boxes.getUserModel();
                                              box.put('user', hiveUserModel);

                                              setState(() {
                                                loading = false;
                                              });

                                              //back
                                              Get.back();
                                            } catch (e) {
                                              setState(() {
                                                loading = false;
                                              });
                                              //back
                                              Get.back();
                                            }
                                          },
                                          style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll<
                                                      Color>(Colors.red)),
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .8,
                                            child: const Text('Keluar Group'),
                                          )),
                                    ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          );
  }
}
