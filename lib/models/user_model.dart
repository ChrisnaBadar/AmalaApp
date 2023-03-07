class UserModels {
  final String? uid;
  final String? uidGroup;
  final String? uidLeader;
  final String? nama;
  final String? email;
  final String? password;
  final String? group;
  final String? lembaga;
  final String? ponsel;
  final String? amanah;
  final Map? yaumi;
  final Map<String, dynamic>? absen;

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
