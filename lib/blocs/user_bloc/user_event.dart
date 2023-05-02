// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

class UserEvent {}

class SetUserName extends UserEvent {
  String nama;
  SetUserName(
    this.nama,
  );
}

class SetUserUid extends UserEvent {
  String uid;
  SetUserUid(
    this.uid,
  );
}

class SetUserUidGroup extends UserEvent {
  String uidGroup;
  SetUserUidGroup(
    this.uidGroup,
  );
}

class SetUserUidLeader extends UserEvent {
  String uidLeader;
  SetUserUidLeader(
    this.uidLeader,
  );
}

class SetUserEmail extends UserEvent {
  String email;
  SetUserEmail(
    this.email,
  );
}

class SetUserPic extends UserEvent {
  String photoUrl;
  SetUserPic(
    this.photoUrl,
  );
}

class SetUserGroup extends UserEvent {
  String uidGroup;
  String uidLeader;
  String group;
  SetUserGroup(this.uidGroup, this.uidLeader, this.group);
}

class SetUserDatabase extends UserEvent {
  String uid;
  String nama;
  String email;
  String photoUrl;
  SetUserDatabase(
    this.uid,
    this.nama,
    this.email,
    this.photoUrl,
  );
}

class DeleteGroupData extends UserEvent {
  String uidGroup;
  String uidLeader;
  String group;
  DeleteGroupData(this.uidGroup, this.uidLeader, this.group);
}
