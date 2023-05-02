// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

class UserState extends Equatable {
  final String uid;
  final String uidGroup;
  final String uidLeader;
  final String nama;
  final String email;
  final String group;
  final String photoUrl;
  const UserState({
    required this.uid,
    required this.uidGroup,
    required this.uidLeader,
    required this.nama,
    required this.email,
    required this.group,
    required this.photoUrl,
  });

  @override
  List<Object> get props =>
      [uid, uidGroup, uidLeader, nama, email, group, photoUrl];

  UserState copyWith(
      {String? uid,
      String? uidGroup,
      String? uidLeader,
      String? nama,
      String? email,
      String? group,
      String? photoUrl}) {
    return UserState(
      uid: uid ?? this.uid,
      uidGroup: uidGroup ?? this.uidGroup,
      uidLeader: uidLeader ?? this.uidLeader,
      nama: nama ?? this.nama,
      email: email ?? this.email,
      group: group ?? this.group,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'uidGroup': uidGroup,
      'uidLeader': uidLeader,
      'nama': nama,
      'email': email,
      'group': group,
      'photoUrl': photoUrl
    };
  }

  factory UserState.fromMap(Map<String, dynamic> map) {
    return UserState(
        uid: map['uid'] as String,
        uidGroup: map['uidGroup'] as String,
        uidLeader: map['uidLeader'] as String,
        nama: map['nama'] as String,
        email: map['email'] as String,
        group: map['group'] as String,
        photoUrl: map['photoUrl'] as String);
  }
}

class UserInitial extends UserState {
  const UserInitial()
      : super(
            uid: '',
            uidGroup: '',
            uidLeader: '',
            nama: '',
            group: '',
            email: '',
            photoUrl: '');
}
