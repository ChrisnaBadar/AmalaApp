class UserModels {
  String? uid;
  String? uidGroup;
  String? uidLeader;
  String? nama;
  String? email;
  String? profilePicUrl;
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
      this.profilePicUrl,
      this.group,
      this.lembaga,
      this.ponsel,
      this.amanah,
      this.yaumi,
      this.absen});
}
