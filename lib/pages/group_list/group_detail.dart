import 'package:amala/constants/core_data.dart';
import 'package:amala/models/group_model.dart';
import 'package:flutter/material.dart';

import '../../services/database_service.dart';

class GroupDetail extends StatefulWidget {
  const GroupDetail({super.key});

  @override
  State<GroupDetail> createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetail> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GroupModel>(
      stream: DatabaseService(uidGroup: CoreData.uidGroup).groupModel,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final groupModel = snapshot.data;
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
                        groupModel!.namaGroup!,
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
                    itemCount: groupModel.member!.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              groupModel.member![index]['photoUrl'],
                              scale: 2),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        SizedBox(
                          width: 70.0,
                          child: Text(
                            groupModel.member![index]['nama'],
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * .8,
                        child: const Text('Gabung Group'),
                      )),
                )
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
