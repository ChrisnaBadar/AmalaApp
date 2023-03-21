import 'package:amala/constants/core_data.dart';
import 'package:amala/constants/my_strings.dart';
import 'package:amala/constants/my_text_styles.dart';
import 'package:amala/models/group_model.dart';
import 'package:amala/models/user_model.dart';
import 'package:amala/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:amala/controllers/group_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../models/hive/boxes.dart';
import '../../models/hive/hive_user_model.dart';
import '../../services/admob_service.dart';
import '../loading/loading.dart';
import 'group_list.dart';

class GroupListPage extends StatefulWidget {
  const GroupListPage({super.key});

  @override
  State<GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  //untuk formbuilder
  final _formKey = GlobalKey<FormBuilderState>();
  bool loading = false;
  final groupController = Get.put(GroupController());
  //admob
  BannerAd? _bannerAd;

  void _createBannerAd() {
    _bannerAd = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: AdMobService.bannerAdUnitId,
        listener: AdMobService.bannerListener,
        request: const AdRequest())
      ..load();
  }

  @override
  void initState() {
    super.initState();
    _createBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<GroupModel>>(
      stream: DatabaseService().groupModelList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final groupList = snapshot.data;
          final checkGroupList = groupList!.map((e) => e.uidGroup).toList();
          return _mainBody(groupList, checkGroupList);
        } else {
          return const Scaffold(
            body: Center(
              child: Text('No Data'),
            ),
          );
        }
      },
    );
  }

  Widget _mainBody(List<GroupModel>? groupList, List checkGroupList) {
    final userModels = UserModels()
      ..uid = CoreData.uid
      ..uidGroup = CoreData.uidGroup
      ..uidLeader = CoreData.uidLeader
      ..nama = CoreData.nama
      ..amanah = CoreData.amanah
      ..email = CoreData.email
      ..group = CoreData.group
      ..lembaga = CoreData.lembaga
      ..profilePicUrl = CoreData.profilePicUrl
      ..ponsel = CoreData.ponsel
      ..absen = {}
      ..yaumi = {};
    final isGroupLeader = groupList!
        .map((e) => e.member!.values)
        .toList()
        .first
        .toList()
        .where((e) => e['uid'] == currentUser!.uid)
        .toList();
    checkGroupList.contains(CoreData.uidGroup)
        ? true
        : DatabaseService(uid: CoreData.uid).updateUserData1('-', '-', '-');
    return loading
        ? const Loading()
        : Scaffold(
            bottomNavigationBar: _bannerAd == null
                ? Container()
                : Container(
                    height: 52,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: AdWidget(ad: _bannerAd!),
                  ),
            floatingActionButton: isGroupLeader.isEmpty
                ? FloatingActionButton.extended(
                    onPressed: () => showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      )),
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: _buildSheet(userModels),
                      ),
                    ),
                    label: const Text('Buat Group'),
                    icon: Image.asset(
                      MyStrings.manIconColor,
                      scale: 3.5,
                    ),
                  )
                : null,
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GroupList(
                            groupList: groupList,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildSheet(UserModels userModels) {
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
    return SizedBox(
      height: 400.0,
      child: Column(
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
                      FormBuilder(
                        key: _formKey,
                        child: FormBuilderTextField(
                          name: 'nama_group',
                          decoration: const InputDecoration(
                              hintText: 'Tulis nama group anda..',
                              border: OutlineInputBorder()),
                          validator: FormBuilderValidators.required(context),
                          onChanged: (val) =>
                              groupController.namaGroup.value = val!,
                        ),
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
                      child: Obx(
                        () => Image.asset(
                          groupController.iconAvatar.value,
                          scale: 1,
                        ),
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
                  onTap: () =>
                      groupController.iconAvatar.value = iconList[index],
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
              _setGroupData(userModels);
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
  }

  void _setGroupData(UserModels userModels) async {
    final validated = _formKey.currentState!.saveAndValidate();
    if (validated) {
      setState(() {
        loading = true;
      });
      await DatabaseService(uid: currentUser!.uid).setGroupData(
          nama: currentUser!.displayName,
          photoUrl: currentUser!.photoURL,
          namaGroup: groupController.namaGroup.value,
          groupIcon: groupController.iconAvatar.value);
      await DatabaseService(uid: currentUser!.uid).updateUserData1(
          currentUser!.uid, currentUser!.uid, groupController.namaGroup.value);
      final userHiveModel = HiveUserModel()
        ..uid = currentUser!.uid
        ..uidGroup = currentUser!.uid
        ..uidLeader = currentUser!.uid
        ..nama = currentUser!.displayName
        ..email = currentUser!.email
        ..profilePicUrl = currentUser!.photoURL
        ..group = groupController.namaGroup.value
        ..lembaga = CoreData.lembaga
        ..ponsel = CoreData.ponsel
        ..amanah = CoreData.amanah;

      final box = Boxes.getUserModel();
      box.put('user', userHiveModel);
      setState(() {
        loading = false;
      });
      Get.back();
    }
  }
}
