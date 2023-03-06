import 'dart:io';
import 'package:amala/models/hive/hive_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../models/hive/boxes.dart';
import '../../loading/Loading.dart';
import '../../splash/splash_screen.dart';
import 'controller/editProfileController.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final editController = Get.put(EditProfileController());
  final _formKey = GlobalKey<FormBuilderState>();

  var updateNama;
  var updateLembaga;
  var updateAmanah;
  var updatePonsel;

  final User? _user = FirebaseAuth.instance.currentUser;
  Map userDetail = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: editController.loading.value
              ? Loading()
              : Scaffold(
                  resizeToAvoidBottomInset: true,
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          //title
                          Container(
                            height: MediaQuery.of(context).size.height * .10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text('My Profile',
                                    style: TextStyle(
                                        fontSize: 35.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey)),
                              ),
                            ),
                          ),

                          //description

                          //Image
                          Container(
                              height: MediaQuery.of(context).size.height * .30,
                              child: imageProfile()),

                          //nama
                          Container(
                            height: MediaQuery.of(context).size.height * .45,
                            child: FormBuilder(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(left: 8.0),
                                        alignment: Alignment.centerLeft,
                                        child: Text('${_user!.displayName}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                                color: Colors.blueGrey))),
                                    SizedBox(
                                      height: 16.0,
                                    ),
                                    EditForm(
                                      name: 'edit_lembaga',
                                      title: 'Edit Lembaga',
                                      initialValue: 'lembaga',
                                      prefixIcon:
                                          Icon(Icons.account_balance_outlined),
                                      onChange: (val) {
                                        updateLembaga = val;
                                      },
                                    ),
                                    EditForm(
                                      name: 'edit_amanah',
                                      title: 'Edit Amanah',
                                      initialValue: 'amanah',
                                      prefixIcon: Icon(Icons.cases_outlined),
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
                                            // await DatabaseService(uid: uid)
                                            //     .updateUserData(updateLembaga,
                                            //         updateAmanah);
                                            final userHiveModel =
                                                HiveUserModel()
                                                  ..uid = _user!.uid
                                                  ..uidGroup = 'uidGroup'
                                                  ..uidLeader = 'uidLeader'
                                                  ..nama = _user!.displayName
                                                  ..email = _user!.email
                                                  ..password = 'password'
                                                  ..group = 'group'
                                                  ..lembaga = updateLembaga
                                                  ..ponsel = _user!.phoneNumber
                                                  ..amanah = updateAmanah;

                                            final box = Boxes.getUserModel();
                                            box.put('user', userHiveModel);
                                            Get.off(() => SplashScreen());
                                          }
                                        },
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          alignment: Alignment.center,
                                          child: Text('SAVE',
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
            child: _user!.photoURL == null ? Icon(Icons.person) : null,
            backgroundImage:
                _user!.photoURL == null ? null : NetworkImage(_user!.photoURL!),
          ),
        )
      ],
    );
  }
}

class EditForm extends StatelessWidget {
  EditForm(
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
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              label: Text(title!),
            ),
          ),
        ),
      ],
    );
  }
}
