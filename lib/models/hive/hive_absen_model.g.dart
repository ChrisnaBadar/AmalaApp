// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_absen_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveAbsenModelAdapter extends TypeAdapter<HiveAbsenModel> {
  @override
  final int typeId = 3;

  @override
  HiveAbsenModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveAbsenModel()
      ..date = fields[0] as DateTime?
      ..tanggal = fields[1] as String?
      ..waktu = fields[2] as String?
      ..kehadiran = fields[3] as String?
      ..keperluan = fields[4] as String?
      ..tanggalIjin = fields[5] as String?
      ..lokasi = fields[6] as String?;
  }

  @override
  void write(BinaryWriter writer, HiveAbsenModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.tanggal)
      ..writeByte(2)
      ..write(obj.waktu)
      ..writeByte(3)
      ..write(obj.kehadiran)
      ..writeByte(4)
      ..write(obj.keperluan)
      ..writeByte(5)
      ..write(obj.tanggalIjin)
      ..writeByte(6)
      ..write(obj.lokasi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveAbsenModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
