import 'package:amala/models/user_model.dart';

class GroupModel {
  final String? uidGroup;
  final String? uidLeader;
  final String? namaGroup;
  final List<UserModels>? member;

  GroupModel({this.uidGroup, this.uidLeader, this.namaGroup, this.member});
}
