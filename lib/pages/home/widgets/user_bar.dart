// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amala/constants/my_strings.dart';
import 'package:amala/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../blocs/bloc_exports.dart';

class Userbar extends StatefulWidget {
  final User? user;
  const Userbar({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  State<Userbar> createState() => _UserbarState();
}

class _UserbarState extends State<Userbar> {
  var myName = '';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settingsState) {
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, userStata) {
            final nama = userStata.nama;
            final uidGroup = userStata.uidGroup;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Card(
                      child: ListTile(
                          leading: widget.user != null
                              ? CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(widget.user!.photoURL!),
                                )
                              : const CircleAvatar(
                                  backgroundImage:
                                      AssetImage(MyStrings.manIconColor),
                                ),
                          title: Text(
                            widget.user != null
                                ? nama == ''
                                    ? widget.user!.displayName!
                                    : nama
                                : 'Selamat Datang',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[800]),
                          ),
                          subtitle: Text(
                            widget.user != null
                                ? uidGroup.isEmpty
                                    ? 'Groupless'
                                    : 'idGroup:$uidGroup'
                                : 'Silahkan Login',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 11.0,
                                color: Colors.blueGrey[400]),
                          ),
                          trailing: widget.user != null
                              ? PopupMenuButton(
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: const Text('Edit Nama'),
                                      onTap: () {
                                        myName = '';
                                        Future.delayed(
                                            Duration.zero,
                                            () => showModalBottomSheet(
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (context) => Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: MediaQuery.of(
                                                                  context)
                                                              .viewInsets
                                                              .bottom),
                                                      child: SizedBox(
                                                        height: 220.0,
                                                        child: Column(
                                                          children: [
                                                            const SizedBox(
                                                              height: 16.0,
                                                            ),
                                                            Text(
                                                              'Edit Nama',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      17.5,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                          .blueGrey[
                                                                      600]),
                                                            ),
                                                            const SizedBox(
                                                              height: 8.0,
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                              child: Text(
                                                                'Untuk kembali menggunakan nama dari Google Account kosongkan text di bawah lalu tap SAVE',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.5,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                            .green[
                                                                        600]),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: TextField(
                                                                decoration: const InputDecoration(
                                                                    border: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(10.0)))),
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    myName =
                                                                        value;
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              child:
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        if (myName ==
                                                                            '') {
                                                                          Navigator.pop(
                                                                              context);
                                                                        } else {
                                                                          context
                                                                              .read<UserBloc>()
                                                                              .add(SetUserName(myName));

                                                                          Navigator.pop(
                                                                              context);
                                                                        }
                                                                      },
                                                                      child: const Text(
                                                                          'SAVE')),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )));
                                      },
                                    ),
                                    PopupMenuItem(
                                      child: const Text('Logout'),
                                      onTap: () => Future.delayed(
                                          Duration.zero,
                                          () => showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    _logoutAlert(context),
                                              )),
                                    ),
                                  ],
                                )
                              : IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/authPage');
                                  },
                                  icon: const Icon(Icons.login))),
                    ),
                  ),
                  widget.user != null
                      ? uidGroup != ''
                          ? settingsState.absen
                              ? _absenButton()
                              : _groupButton()
                          : _groupButton()
                      : Container()
                ],
              ),
            );
          },
        );
      },
    );
  }

  _absenButton() {
    return Expanded(
        flex: 1,
        child: SizedBox(
          height: 70.0,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/absenPage');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Icon(Icons.description), Text('Absen')],
            ),
          ),
        ));
  }

  _groupButton() {
    return Expanded(
        flex: 1,
        child: SizedBox(
          height: 70.0,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/groupListPage');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Icon(Icons.group), Text('Groups')],
            ),
          ),
        ));
  }

  AlertDialog _logoutAlert(context) {
    return AlertDialog(
      content: const Text('Anda ingin logout?'),
      actions: [
        TextButton(
            onPressed: () async {
              await AuthService().signOut(context);
              Navigator.pushReplacementNamed(context, '/');
            },
            child: const Text('Yes')),
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text('No')),
      ],
    );
  }
}
