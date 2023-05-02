import 'package:amala/constants/my_strings.dart';
import 'package:flutter/material.dart';
import '../../services/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSingInProvider(),
      builder: (context, child) {
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
                                      fontSize:
                                          (MediaQuery.of(context).size.width *
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
                                style:
                                    TextStyle(fontWeight: FontWeight.normal)),
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
                            final provider = Provider.of<GoogleSingInProvider>(
                                context,
                                listen: false);
                            provider.googleLogIn(context);
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
      },
    );
  }
}
