import 'package:equatable/equatable.dart';

import '../bloc_exports.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  UserBloc() : super(const UserInitial()) {
    on<SetUserName>((event, emit) {
      var nama = state.nama;
      nama = event.nama;
      emit(state.copyWith(nama: nama));
    });
    on<SetUserUid>((event, emit) {
      var uid = state.uid;
      uid = event.uid;
      emit(state.copyWith(uid: uid));
    });
    on<SetUserUidGroup>((event, emit) {
      var uidGroup = state.uidGroup;
      uidGroup = event.uidGroup;
      emit(state.copyWith(uidGroup: uidGroup));
    });
    on<SetUserUidLeader>((event, emit) {
      var uidLeader = state.uidLeader;
      uidLeader = event.uidLeader;
      emit(state.copyWith(uidLeader: uidLeader));
    });
    on<SetUserEmail>((event, emit) {
      var email = state.email;
      email = event.email;
      emit(state.copyWith(email: email));
    });
    on<SetUserGroup>((event, emit) {
      var uidGroup = state.uidGroup;
      var uidLeader = state.uidLeader;
      var group = state.group;
      uidGroup = event.uidGroup;
      uidLeader = event.uidLeader;
      group = event.group;
      emit(state.copyWith(
          uidGroup: uidGroup, uidLeader: uidLeader, group: group));
    });
    on<DeleteGroupData>((event, emit) {
      var uidGroup = state.uidGroup;
      var uidLeader = state.uidLeader;
      var group = state.group;
      uidGroup = event.uidGroup;
      uidLeader = event.uidLeader;
      group = event.group;
      emit(state.copyWith(
          uidGroup: uidGroup, uidLeader: uidLeader, group: group));
    });
    on<SetUserPic>((event, emit) {
      var photoUrl = state.photoUrl;
      photoUrl = event.photoUrl;
      emit(state.copyWith(photoUrl: photoUrl));
    });
    on<SetUserDatabase>((event, emit) {
      var uid = state.uid;
      var nama = state.nama;
      var email = state.email;
      var photoUrl = state.photoUrl;
      uid = event.uid;
      nama = event.nama;
      email = event.email;
      photoUrl = event.photoUrl;
      emit(state.copyWith(
          uid: uid, nama: nama, email: email, photoUrl: photoUrl));
    });
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    return UserState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    return state.toMap();
  }
}
