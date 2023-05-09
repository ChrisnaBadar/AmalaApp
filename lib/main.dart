import 'package:alarm/alarm.dart';
import 'package:amala/constants/core_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'blocs/bloc_exports.dart';
import 'constants/my_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //admob init
  RequestConfiguration configuration =
      RequestConfiguration(testDeviceIds: CoreData.testDeviceIds);
  MobileAds.instance.updateRequestConfiguration(configuration);
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  //await Upgrader.clearSavedSettings();
  await Alarm.init();
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  HydratedBloc.storage = storage;
  // Bloc.observer = MyBlocObserver();

  await initializeDateFormatting('id_ID', null)
      .then((value) => runApp(const Amala()));
}

class Amala extends StatelessWidget {
  const Amala({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SettingsBloc(),
        ),
        BlocProvider(
          create: (context) => SelectedDateBloc(),
        ),
        BlocProvider(
          create: (context) => YaumiBloc(),
        ),
        BlocProvider(
          create: (context) => AbsenBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Amala',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: CoreData.isTestMode,
        routes: MyRoutes().routes,
      ),
    );
  }
}
