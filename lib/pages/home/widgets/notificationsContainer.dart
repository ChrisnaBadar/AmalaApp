import 'package:flutter/material.dart';

Widget notificationsContainer({@required BuildContext? context}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.blueGrey[800],
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            //Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Title
                  Text('Dear Pengguna,',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(
                    height: 4.0,
                  ),

                  //Description
                  Text(
                      'Aplikasi dalam pengembangan. Silahkan login untuk save data Yaumi agar tidak hilang.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.white))
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
