import 'package:amala/constants/core_data.dart';
import 'package:amala/models/hive/hive_user_model.dart';
import 'package:amala/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../models/hive/boxes.dart';
import '../../loading/loading.dart';
import '../../splash/splash_screen.dart';
import 'controller/edit_profile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final editController = Get.put(EditProfileController());
  final _formKey = GlobalKey<FormBuilderState>();

  String? updateNama;
  String? updateLembaga;
  String? updateAmanah;
  String? updatePonsel;

  final User? _user = FirebaseAuth.instance.currentUser;
  Map userDetail = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: editController.loading.value
              ? const Loading()
              : Scaffold(
                  resizeToAvoidBottomInset: true,
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          //title
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: const Text('My Profile',
                                    style: TextStyle(
                                        fontSize: 35.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey)),
                              ),
                            ),
                          ),

                          //description

                          //Image
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .30,
                              child: imageProfile()),

                          //nama
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .45,
                            child: FormBuilder(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Container(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        alignment: Alignment.centerLeft,
                                        child: Text('${_user!.displayName}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                                color: Colors.blueGrey))),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    EditForm(
                                      name: 'edit_lembaga',
                                      title: 'Edit Lembaga',
                                      initialValue: 'lembaga',
                                      prefixIcon: const Icon(
                                          Icons.account_balance_outlined),
                                      onChange: (val) {
                                        updateLembaga = val;
                                      },
                                    ),
                                    EditForm(
                                      name: 'edit_amanah',
                                      title: 'Edit Amanah',
                                      initialValue: 'amanah',
                                      prefixIcon:
                                          const Icon(Icons.cases_outlined),
                                      onChange: (val) {
                                        updateAmanah = val;
                                      },
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          editController.loading.value = true;
                                          final validationSuccess = _formKey
                                              .currentState!
                                              .saveAndValidate();
                                          if (validationSuccess) {
                                            await DatabaseService(
                                                    uid: CoreData.uid)
                                                .updateUserData(updateLembaga!,
                                                    updateAmanah!);
                                            final userHiveModel =
                                                HiveUserModel()
                                                  ..uid = _user!.uid
                                                  ..uidGroup = CoreData.uidGroup
                                                  ..uidLeader =
                                                      CoreData.uidLeader
                                                  ..nama = _user!.displayName
                                                  ..email = _user!.email
                                                  ..password = CoreData.password
                                                  ..group = CoreData.group
                                                  ..lembaga = updateLembaga
                                                  ..ponsel = _user!.phoneNumber
                                                  ..amanah = updateAmanah;

                                            final box = Boxes.getUserModel();
                                            box.put('user', userHiveModel);
                                            Get.off(() => const SplashScreen());
                                          }
                                        },
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          alignment: Alignment.center,
                                          child: const Text('SAVE',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ))
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 75.0,
          child: CircleAvatar(
            radius: 72.5,
            backgroundColor: Colors.amber,
            backgroundImage:
                _user!.photoURL == null ? null : NetworkImage(_user!.photoURL!),
            child: _user!.photoURL == null ? const Icon(Icons.person) : null,
          ),
        )
      ],
    );
  }
}

class EditForm extends StatelessWidget {
  const EditForm(
      {Key? key,
      this.name,
      this.title,
      this.initialValue,
      this.prefixIcon,
      this.onChange})
      : super(key: key);

  final String? name;
  final String? title;
  final String? initialValue;
  final Widget? prefixIcon;
  final ValueChanged? onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: FormBuilderTextField(
            name: name!,
            initialValue: initialValue,
            onChanged: onChange,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              label: Text(title!),
            ),
          ),
        ),
      ],
    );
  }
}
