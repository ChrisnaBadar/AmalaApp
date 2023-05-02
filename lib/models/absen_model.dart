// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AbsenModel extends Equatable {
  final DateTime date;
  final String tanggal;
  final String nama;
  final String waktu;
  final String lokasi;
  final String kehadiran;
  final String tanggalIjin;
  final String keperluan;
  const AbsenModel({
    required this.date,
    required this.tanggal,
    required this.nama,
    required this.waktu,
    required this.lokasi,
    required this.kehadiran,
    required this.tanggalIjin,
    required this.keperluan,
  });

  @override
  List<Object?> get props => [
        date,
        tanggal,
        nama,
        waktu,
        lokasi,
        kehadiran,
        tanggalIjin,
        keperluan,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'tanggal': tanggal,
      'nama': nama,
      'waktu': waktu,
      'lokasi': lokasi,
      'kehadiran': kehadiran,
      'tanggalIjin': tanggalIjin,
      'keperluan': keperluan,
    };
  }

  factory AbsenModel.fromMap(Map<String, dynamic> map) {
    return AbsenModel(
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      tanggal: map['tanggal'] as String,
      waktu: map['waktu'] as String,
      lokasi: map['lokasi'] as String,
      kehadiran: map['kehadiran'] as String,
      tanggalIjin: map['tanggalIjin'] as String,
      keperluan: map['keperluan'] as String,
      nama: map['nama'] as String,
    );
  }

  AbsenModel copyWith({
    DateTime? date,
    String? tanggal,
    String? nama,
    String? waktu,
    String? lokasi,
    String? kehadiran,
    String? tanggalIjin,
    String? keperluan,
  }) {
    return AbsenModel(
      date: date ?? this.date,
      tanggal: tanggal ?? this.tanggal,
      nama: nama ?? this.nama,
      waktu: waktu ?? this.waktu,
      lokasi: lokasi ?? this.lokasi,
      kehadiran: kehadiran ?? this.kehadiran,
      tanggalIjin: tanggalIjin ?? this.tanggalIjin,
      keperluan: keperluan ?? this.keperluan,
    );
  }
}
