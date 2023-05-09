// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:amala/models/groups_model.dart';
import 'package:amala/services/database_service.dart';
import '../../blocs/bloc_exports.dart';

class GroupTile extends StatefulWidget {
  final GroupsModel groupsModel;
  const GroupTile({
    Key? key,
    required this.groupsModel,
  }) : super(key: key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final members = widget.groupsModel.member!.values.toList();
    return Card(
      child: ListTile(
        trailing: CircleAvatar(
          radius: 25.0,
          child: Image.asset(
            widget.groupsModel.groupIcon!,
            scale: 1,
          ),
        ),
        title: Text(
          widget.groupsModel.namaGroup!,
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
            Text('${widget.groupsModel.member!.length} Orang')
          ],
        ),
        isThreeLine: true,
        onTap: () => showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
          builder: (context) => _buildSheet(widget.groupsModel, members),
        ),
      ),
    );
  }

  Widget _buildSheet(GroupsModel groupModel, List members) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return SizedBox(
          height: 315.0,
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
                        backgroundImage:
                            NetworkImage(members[index]['photoUrl'], scale: 2),
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
              state.uidGroup == ''
                  ? _joinButton(state.uid, groupModel.uidLeader, state.nama,
                      state.photoUrl, groupModel.namaGroup)
                  : Container(),
              state.uid == groupModel.uidLeader
                  ? _deleteButton(state.uid)
                  : state.uidGroup == groupModel.uidGroup
                      ? _unjoinButton(state.uid, groupModel.uidLeader)
                      : Container()
            ],
          ),
        );
      },
    );
  }

  _joinButton(uid, uidLeader, nama, photoUrl, namaGroup) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: ElevatedButton(
          onPressed: () {
            setState(() {
              loading = true;
            });
            try {
              DatabaseService(uid: uid, uidLeader: uidLeader)
                  .joinGroup(nama, photoUrl, namaGroup);
              context
                  .read<UserBloc>()
                  .add(SetUserGroup(uidLeader, uidLeader, namaGroup));
              setState(() {
                loading = false;
              });
              Navigator.pop(context);
            } catch (e) {
              setState(() {
                loading = false;
              });
            }
          },
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * .8,
            child: const Text('Gabung Group'),
          )),
    );
  }

  _unjoinButton(uid, uidLeader) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: ElevatedButton(
          onPressed: () async {
            setState(() {
              loading = true;
            });
            try {
              DatabaseService(uid: uid, uidLeader: uidLeader).unjoinGroup();
              context.read<UserBloc>().add(DeleteGroupData('', '', ''));
              setState(() {
                loading = false;
              });
              Navigator.pop(context);
            } catch (e) {
              setState(() {
                loading = false;
              });
            }
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red)),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * .8,
            child: const Text('Keluar Group'),
          )),
    );
  }

  _deleteButton(uid) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
          ),
          onPressed: () => showDialog(
                context: context,
                builder: (context) => _deleteAlert(uid),
              ).then((value) => Navigator.pop(context)),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * .8,
            child: const Text('Hapus Group'),
          )),
    );
  }

  _deleteAlert(uid) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return AlertDialog(
          content: const Text('Anda yakin akan menghapus group ini?'),
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    loading = true;
                  });
                  try {
                    DatabaseService(uidLeader: uid, uid: uid).removeGroup();
                    context.read<UserBloc>().add(DeleteGroupData('', '', ''));
                    Navigator.pop(context);
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                  }
                },
                child: const Text('Yes')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'))
          ],
        );
      },
    );
  }
}
