import 'package:equatable/equatable.dart';

class YaumiModel extends Equatable {
  final String id;
  final DateTime date;
  final String nama;
  bool? shubuh;
  bool? dhuhur;
  bool? ashar;
  bool? maghrib;
  bool? isya;
  bool? tahajud;
  bool? rawatib;
  bool? dhuha;
  int? tilawah;
  bool? shaum;
  bool? sedekah;
  bool? dzikirPagi;
  bool? dzikirPetang;
  bool? taklim;
  bool? istighfar;
  bool? shalawat;
  double? poinHariIni;
  bool? isSubmitted;
  YaumiModel(
      {required this.id,
      required this.date,
      required this.nama,
      this.shubuh,
      this.dhuhur,
      this.ashar,
      this.maghrib,
      this.isya,
      this.tahajud,
      this.rawatib,
      this.dhuha,
      this.tilawah,
      this.shaum,
      this.sedekah,
      this.dzikirPagi,
      this.dzikirPetang,
      this.taklim,
      this.istighfar,
      this.shalawat,
      this.poinHariIni,
      this.isSubmitted}) {
    shubuh = shubuh ?? false;
    dhuhur = dhuhur ?? false;
    ashar = ashar ?? false;
    maghrib = maghrib ?? false;
    isya = isya ?? false;
    tahajud = tahajud ?? false;
    rawatib = rawatib ?? false;
    dhuha = dhuha ?? false;
    tilawah = tilawah ?? 0;
    shaum = shaum ?? false;
    sedekah = sedekah ?? false;
    dzikirPagi = dzikirPagi ?? false;
    dzikirPetang = dzikirPetang ?? false;
    taklim = taklim ?? false;
    istighfar = istighfar ?? false;
    shalawat = shalawat ?? false;
    poinHariIni = poinHariIni ?? 0.0;
    isSubmitted = isSubmitted ?? false;
  }

  @override
  List<Object?> get props => [
        id,
        date,
        nama,
        shubuh,
        dhuhur,
        ashar,
        maghrib,
        isya,
        tahajud,
        rawatib,
        dhuha,
        tilawah,
        shaum,
        sedekah,
        dzikirPagi,
        dzikirPetang,
        taklim,
        istighfar,
        shalawat,
        poinHariIni,
        isSubmitted
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'nama': nama,
      'shubuh': shubuh,
      'dhuhur': dhuhur,
      'ashar': ashar,
      'maghrib': maghrib,
      'isya': isya,
      'tahajud': tahajud,
      'rawatib': rawatib,
      'dhuha': dhuha,
      'tilawah': tilawah,
      'shaum': shaum,
      'sedekah': sedekah,
      'dzikirPagi': dzikirPagi,
      'dzikirPetang': dzikirPetang,
      'taklim': taklim,
      'istighfar': istighfar,
      'shalawat': shalawat,
      'poinHariIni': poinHariIni,
      'isSubmitted': isSubmitted
    };
  }

  factory YaumiModel.fromMap(Map<String, dynamic> map) {
    return YaumiModel(
      id: map['id'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      nama: map['nama'] as String,
      shubuh: map['shubuh'] != null ? map['shubuh'] as bool : null,
      dhuhur: map['dhuhur'] != null ? map['dhuhur'] as bool : null,
      ashar: map['ashar'] != null ? map['ashar'] as bool : null,
      maghrib: map['maghrib'] != null ? map['maghrib'] as bool : null,
      isya: map['isya'] != null ? map['isya'] as bool : null,
      tahajud: map['tahajud'] != null ? map['tahajud'] as bool : null,
      rawatib: map['rawatib'] != null ? map['rawatib'] as bool : null,
      dhuha: map['dhuha'] != null ? map['dhuha'] as bool : null,
      tilawah: map['tilawah'] != null ? map['tilawah'] as int : null,
      shaum: map['shaum'] != null ? map['shaum'] as bool : null,
      sedekah: map['sedekah'] != null ? map['sedekah'] as bool : null,
      dzikirPagi: map['dzikirPagi'] != null ? map['dzikirPagi'] as bool : null,
      dzikirPetang:
          map['dzikirPetang'] != null ? map['dzikirPetang'] as bool : null,
      taklim: map['taklim'] != null ? map['taklim'] as bool : null,
      istighfar: map['istighfar'] != null ? map['istighfar'] as bool : null,
      shalawat: map['shalawat'] != null ? map['shalawat'] as bool : null,
      poinHariIni:
          map['poinHariIni'] != null ? map['poinHariIni'] as double : null,
      isSubmitted:
          map['isSubmitted'] != null ? map['isSubmitted'] as bool : null,
    );
  }

  YaumiModel copyWith({
    String? id,
    DateTime? date,
    String? nama,
    bool? shubuh,
    bool? dhuhur,
    bool? ashar,
    bool? maghrib,
    bool? isya,
    bool? tahajud,
    bool? rawatib,
    bool? dhuha,
    int? tilawah,
    bool? shaum,
    bool? sedekah,
    bool? dzikirPagi,
    bool? dzikirPetang,
    bool? taklim,
    bool? istighfar,
    bool? shalawat,
    double? poinHariIni,
    bool? isSubmitted,
  }) {
    return YaumiModel(
      id: id ?? this.id,
      date: date ?? this.date,
      nama: nama ?? this.nama,
      shubuh: shubuh ?? this.shubuh,
      dhuhur: dhuhur ?? this.dhuhur,
      ashar: ashar ?? this.ashar,
      maghrib: maghrib ?? this.maghrib,
      isya: isya ?? this.isya,
      tahajud: tahajud ?? this.tahajud,
      rawatib: rawatib ?? this.rawatib,
      dhuha: dhuha ?? this.dhuha,
      tilawah: tilawah ?? this.tilawah,
      shaum: shaum ?? this.shaum,
      sedekah: sedekah ?? this.sedekah,
      dzikirPagi: dzikirPagi ?? this.dzikirPagi,
      dzikirPetang: dzikirPetang ?? this.dzikirPetang,
      taklim: taklim ?? this.taklim,
      istighfar: istighfar ?? this.istighfar,
      shalawat: shalawat ?? this.shalawat,
      poinHariIni: poinHariIni ?? this.poinHariIni,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }
}
