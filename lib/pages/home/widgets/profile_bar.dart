import 'package:amala/constants/my_strings.dart';
import 'package:amala/models/hive/hive_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../auth/auth.dart';

final today = DateTime.now();
final hari = DateFormat('EEEE', "id_ID").format(today);
final formatTanggal = DateFormat('dd MMMM yyyy', "id_ID").format(today);

Widget profilesBar(BuildContext context, User? user, String kota,
    String wilayah, HiveUserModel userHiveModel) {
  // var uidGroup = userHiveModel.uidGroup;
  // var uidLeader = userHiveModel.uidLeader;
  // var lembaga = userHiveModel.lembaga;
  // var amanah = userHiveModel.amanah;
  // var group = userHiveModel.group;
  // var profilePicUrl = userHiveModel.profilePicUrl;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      MyStrings.calenderIconColor,
                      scale: 3,
                    ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: '$hari, ',
                          style: const TextStyle(
                              color: Colors.blueGrey, fontSize: 12.5)),
                      TextSpan(
                          text: formatTanggal,
                          style: const TextStyle(
                              color: Colors.blue, fontSize: 12.5))
                    ])),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .35,
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text: '$wilayah, ',
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 12.5)),
                          TextSpan(
                              text: kota,
                              style: const TextStyle(
                                  color: Colors.blueGrey, fontSize: 12.5))
                        ]),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    Image.asset(
                      MyStrings.locationPinIconColor,
                      scale: 3,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        user != null
            ? Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                    color: Colors.white),
                child: ListTile(
                    isThreeLine: true,
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.photoURL!),
                    ),
                    title: Text('${user.displayName}'),
                    subtitle: Text('${user.email}')),
              )
            : Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                    color: Colors.white),
                child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: const Text('New User'),
                    subtitle: const Text('Silahkan login untuk fitur lainnya'),
                    trailing: IconButton(
                      onPressed: () => Get.to(() => const Auth()),
                      icon: const Icon(
                        Icons.login,
                        color: Colors.blue,
                      ),
                    )),
              )
      ],
    ),
  );
}
