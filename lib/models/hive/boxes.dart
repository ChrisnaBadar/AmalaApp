import 'package:amala/models/hive/hive_user_model.dart';
import 'package:amala/models/hive/hive_yaumi_active_model.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<HiveUserModel> getModel() =>
      Hive.box<HiveUserModel>('hiveUserModel');

  static Box<HiveYaumiActiveModel> getYaumiActiveModel() =>
      Hive.box<HiveYaumiActiveModel>('hiveYaumiActiveModel');
}
