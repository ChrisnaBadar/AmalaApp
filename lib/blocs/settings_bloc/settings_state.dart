// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final bool absen;
  final bool shalatReminder;
  final bool fardhu;
  final bool tahajud;
  final bool dhuha;
  final bool rawatib;
  final bool tilawah;
  final bool shaum;
  final bool sedekah;
  final bool dzikir;
  final bool taklim;
  final bool shalawat;
  final bool istighfar;
  final String selectedGroupIcons;
  final int reportSelectedDate;
  final String namaLembaga;
  const SettingsState({
    required this.absen,
    required this.shalatReminder,
    required this.fardhu,
    required this.tahajud,
    required this.dhuha,
    required this.rawatib,
    required this.tilawah,
    required this.shaum,
    required this.sedekah,
    required this.dzikir,
    required this.taklim,
    required this.shalawat,
    required this.istighfar,
    required this.selectedGroupIcons,
    required this.reportSelectedDate,
    required this.namaLembaga,
  });

  @override
  List<Object> get props => [
        absen,
        shalatReminder,
        fardhu,
        tahajud,
        dhuha,
        rawatib,
        tilawah,
        shaum,
        sedekah,
        dzikir,
        taklim,
        shalawat,
        istighfar,
        selectedGroupIcons,
        reportSelectedDate,
        namaLembaga
      ];

  SettingsState copyWith(
      {bool? absen,
      bool? shalatReminder,
      bool? fardhu,
      bool? tahajud,
      bool? dhuha,
      bool? rawatib,
      bool? tilawah,
      bool? shaum,
      bool? sedekah,
      bool? dzikir,
      bool? taklim,
      bool? shalawat,
      bool? istighfar,
      String? selectedGroupIcons,
      int? reportSelectedDate,
      String? namaLembaga}) {
    return SettingsState(
        absen: absen ?? this.absen,
        shalatReminder: shalatReminder ?? this.shalatReminder,
        fardhu: fardhu ?? this.fardhu,
        tahajud: tahajud ?? this.tahajud,
        dhuha: dhuha ?? this.dhuha,
        rawatib: rawatib ?? this.rawatib,
        tilawah: tilawah ?? this.tilawah,
        shaum: shaum ?? this.shaum,
        sedekah: sedekah ?? this.sedekah,
        dzikir: dzikir ?? this.dzikir,
        taklim: taklim ?? this.taklim,
        shalawat: shalawat ?? this.shalawat,
        istighfar: istighfar ?? this.istighfar,
        selectedGroupIcons: selectedGroupIcons ?? this.selectedGroupIcons,
        reportSelectedDate: reportSelectedDate ?? this.reportSelectedDate,
        namaLembaga: namaLembaga ?? this.namaLembaga);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'absen': absen,
      'shalatReminder': shalatReminder,
      'fardhu': fardhu,
      'tahajud': tahajud,
      'dhuha': dhuha,
      'rawatib': rawatib,
      'tilawah': tilawah,
      'shaum': shaum,
      'sedekah': sedekah,
      'dzikir': dzikir,
      'taklim': taklim,
      'shalawat': shalawat,
      'istighfar': istighfar,
      'selectedGroupIcons': selectedGroupIcons,
      'reportSelectedDate': reportSelectedDate,
      'namaLembaga': namaLembaga
    };
  }

  factory SettingsState.fromMap(Map<String, dynamic> map) {
    return SettingsState(
        absen: map['absen'] as bool,
        shalatReminder: map['shalatReminder'] as bool,
        fardhu: map['fardhu'] as bool,
        tahajud: map['tahajud'] as bool,
        dhuha: map['dhuha'] as bool,
        rawatib: map['rawatib'] as bool,
        tilawah: map['tilawah'] as bool,
        shaum: map['shaum'] as bool,
        sedekah: map['sedekah'] as bool,
        dzikir: map['dzikir'] as bool,
        taklim: map['taklim'] as bool,
        shalawat: map['shalawat'] as bool,
        istighfar: map['istighfar'] as bool,
        selectedGroupIcons: map['selectedGroupIcons'] as String,
        reportSelectedDate: map['reportSelectedDate'] as int,
        namaLembaga: map['namaLembaga'] as String);
  }
}

class SettingsInitial extends SettingsState {
  const SettingsInitial()
      : super(
            absen: false,
            shalatReminder: false,
            fardhu: false,
            tahajud: false,
            dhuha: false,
            rawatib: false,
            tilawah: false,
            shaum: false,
            sedekah: false,
            dzikir: false,
            taklim: false,
            shalawat: false,
            istighfar: false,
            selectedGroupIcons: MyStrings.shalawatIconColor,
            reportSelectedDate: 11,
            namaLembaga: '[Nama Lembaga]');
}
