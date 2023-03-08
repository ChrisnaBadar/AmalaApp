class UserModels {
  String? uid;
  String? uidGroup;
  String? uidLeader;
  String? nama;
  String? email;
  String? password;
  String? group;
  String? lembaga;
  String? ponsel;
  String? amanah;
  Map? yaumi;
  Map<String, dynamic>? absen;

  UserModels(
      {this.uid,
      this.uidGroup,
      this.uidLeader,
      this.nama,
      this.email,
      this.password,
      this.group,
      this.lembaga,
      this.ponsel,
      this.amanah,
      this.yaumi,
      this.absen});
}
