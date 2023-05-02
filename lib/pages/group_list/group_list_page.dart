import 'package:amala/models/groups_model.dart';
import 'package:amala/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../blocs/bloc_exports.dart';
import '../../constants/my_strings.dart';
import '../../constants/my_text_styles.dart';
import 'group_list.dart';

class GroupListPage extends StatefulWidget {
  const GroupListPage({super.key});

  @override
  State<GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  var myGroupName = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: state.uidGroup == '' ? _myFab() : Container(),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  height: 35.0,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Daftar Group',
                        style: TextStyle(
                            fontSize: 17.5,
                            color: Colors.blueGrey[700],
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                StreamBuilder<List<GroupsModel>>(
                    stream: DatabaseService().groupModelList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final groupsModel = snapshot.data;
                        return Expanded(
                            child: GroupList(
                          groupsModel: groupsModel!,
                        ));
                      } else {
                        return Container();
                      }
                    }),
              ],
            ),
          ),
        );
      },
    );
  }

  _myFab() {
    return FloatingActionButton.extended(
      onPressed: () => showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        )),
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: _buildSheet(context),
        ),
      ),
      label: const Text('Buat Group'),
      icon: Image.asset(
        MyStrings.manIconColor,
        scale: 3.5,
      ),
    );
  }

  Widget _buildSheet(BuildContext context) {
    List iconList = [
      MyStrings.absenIconColor,
      MyStrings.checkedIconColor,
      MyStrings.dhuhaIconColor,
      MyStrings.saveIconColor,
      MyStrings.docIconColor,
      MyStrings.sedekahIconColor,
      MyStrings.dzikirIconColor,
      MyStrings.fardhuIconColor,
      MyStrings.shaumIconColor,
      MyStrings.imigrationIconColor,
      MyStrings.istighfarIconColor,
      MyStrings.manIconColor,
      MyStrings.readingQuran,
      MyStrings.rawatibIconColor,
      MyStrings.shalawatIconColor,
      MyStrings.tahajudIconColor,
      MyStrings.taklimIconColor,
      MyStrings.womanIconColor
    ];
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        return BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, settingsState) {
            return SizedBox(
              height: 400.0,
              child: loading
                  ? const Center(
                      child: SpinKitDancingSquare(
                        color: Colors.amber,
                      ),
                    )
                  : Column(
                      children: [
                        const SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          width: 75.0,
                          height: 3.0,
                          color: Colors.blueGrey,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Group Baru',
                                style: MyTextStyles.header(),
                              )),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Nama Group',
                                      style: MyTextStyles.header2(),
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    TextField(
                                      decoration: const InputDecoration(
                                          hintText: 'Tulis nama group anda..',
                                          border: OutlineInputBorder()),
                                      onChanged: (val) {
                                        setState(() {
                                          myGroupName = val;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: CircleAvatar(
                                  radius: 35.0,
                                  backgroundColor: Colors.green,
                                  child: CircleAvatar(
                                    radius: 30.0,
                                    child: Image.asset(
                                      settingsState.selectedGroupIcons,
                                      scale: 1,
                                    ),
                                  ),
                                ),
                              )
                            ],
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  'Pilih Icon Group',
                                  style: MyTextStyles.header2(),
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50.0,
                          child: ListView.builder(
                            itemCount: iconList.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  context.read<SettingsBloc>().add(
                                      SetSelectedGroupIconsEvent(
                                          iconList[index]));
                                },
                                child: CircleAvatar(
                                  child: Image.asset(iconList[index]),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });
                            try {
                              await DatabaseService(uid: userState.uid)
                                  .setGroupData(
                                      userState.nama,
                                      userState.photoUrl,
                                      myGroupName,
                                      settingsState.selectedGroupIcons);

                              // ignore: use_build_context_synchronously
                              context.read<UserBloc>().add(SetUserGroup(
                                  userState.uid, userState.uid, myGroupName));
                              setState(() {
                                loading = false;
                              });

                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            } catch (e) {
                              setState(() {
                                loading = false;
                              });
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * .5,
                            child: const Text('Buat Group'),
                          ),
                        )
                      ],
                    ),
            );
          },
        );
      },
    );
  }
}
