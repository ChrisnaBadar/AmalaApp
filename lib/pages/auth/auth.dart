import 'package:amala/constants/my_strings.dart';
import 'package:amala/models/hive/hive_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/hive/boxes.dart';
import '../../services/google_sign_in.dart';
import '../loading/Loading.dart';
import 'auth_controller.dart';
import 'package:provider/provider.dart';

class Auth extends StatefulWidget {
  const Auth();

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final controller = Get.put(AuthController());
  final _formKey = GlobalKey<FormBuilderState>();
  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<AuthController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSingInProvider(),
      builder: (context, child) {
        return Obx(
          () => GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
              child: controller.loading.value
                  ? Loading()
                  : ValueListenableBuilder<Box<HiveUserModel>>(
                      valueListenable: Boxes.getUserModel().listenable(),
                      builder: (context, box, _) {
                        final useraHiveModel =
                            box.values.toList().cast<HiveUserModel>();
                        final userUid = useraHiveModel.first.uid;
                        print(userUid);
                        return StreamBuilder<HiveUserModel>(
                          stream: null,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return _mainBody(context, true);
                            } else {
                              return _mainBody(context, false);
                            }
                          },
                        );
                      },
                    )),
        );
      },
    );
  }

  Widget _mainBody(_context, bool userExist) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.indigo[50],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Header
              SizedBox(
                width: MediaQuery.of(_context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //image
                    Image.asset(
                      MyStrings.personSit,
                      width: MediaQuery.of(_context).size.width * .40,
                    ),

                    //text
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(_context).size.width * .50,
                      child: Column(
                        children: [
                          Text('YAUMI',
                              style: TextStyle(
                                  fontSize:
                                      (MediaQuery.of(_context).size.width *
                                              .45) /
                                          5,
                                  fontWeight: FontWeight.bold)),
                          Text('V. 3.0.1 all rights reserved',
                              style: TextStyle(fontSize: 10))
                        ],
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 16.0,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text('Assalamu\'alaikum,',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                            'Selamat datang di aplikasi Yaumi. Silahkan melakukan login atau registrasi menggunakan akun Google melalui tombol di bawah ini.',
                            style: TextStyle(fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
                ),
              ),

              //Body
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: () {
                          controller.loading.value = true;
                          final provider = Provider.of<GoogleSingInProvider>(
                              _context,
                              listen: false);
                          provider.googleLogIn(userExist);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.login,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                'Google',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
