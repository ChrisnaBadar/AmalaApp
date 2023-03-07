import 'package:amala/constants/my_strings.dart';
import 'package:amala/models/hive/hive_user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/hive/boxes.dart';
import '../../services/google_sign_in.dart';
import '../loading/loading.dart';
import 'auth_controller.dart';
import 'package:provider/provider.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final controller = Get.put(AuthController());

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
                  ? const Loading()
                  : ValueListenableBuilder<Box<HiveUserModel>>(
                      valueListenable: Boxes.getUserModel().listenable(),
                      builder: (context, box, _) {
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

  Widget _mainBody(context, bool userExist) {
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
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //image
                    Image.asset(
                      MyStrings.personSit,
                      width: MediaQuery.of(context).size.width * .40,
                    ),

                    //text
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * .50,
                      child: Column(
                        children: [
                          Text(MyStrings.appName,
                              style: TextStyle(
                                  fontSize: (MediaQuery.of(context).size.width *
                                          .45) /
                                      5,
                                  fontWeight: FontWeight.bold)),
                          const Text(
                              '${MyStrings.appVersion} ${MyStrings.allRights}',
                              style: TextStyle(fontSize: 10))
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 16.0,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: const [
                        Text(MyStrings.salamShort,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(MyStrings.loginNote,
                            style: TextStyle(fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
                ),
              ),

              //Body
              Column(
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
                            context,
                            listen: false);
                        provider.googleLogIn(userExist);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.login,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              MyStrings.google,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}
