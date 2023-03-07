import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/user_model.dart';
import '../../../services/database_service.dart';
import '../model/absen_model.dart';

class AbsenReportPage extends StatefulWidget {
  const AbsenReportPage({super.key});

  @override
  State<AbsenReportPage> createState() => _AbsenReportPageState();
}

class _AbsenReportPageState extends State<AbsenReportPage> {
  final User? _user = FirebaseAuth.instance.currentUser;
  AbsenModel? absenModel;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModels>(
      stream: DatabaseService(uid: _user!.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userModels = snapshot.data;
          final myAbsenModel = userModels!.absen;
          final absenResult =
              myAbsenModel!.entries.map((e) => e.value).toList();
          return _mainBody(hasData: true, userAbsen: absenResult);
        } else {
          return _mainBody(hasData: false);
        }
      },
    );
  }

  Widget _mainBody({bool? hasData, List? userAbsen}) {
    return Scaffold(
        body: hasData!
            ? ListView.builder(
                itemCount: userAbsen!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(userAbsen[index]['tanggal']),
                  ),
                ),
              )
            : const Center(
                child: Text('No Data'),
              ));
  }
}
