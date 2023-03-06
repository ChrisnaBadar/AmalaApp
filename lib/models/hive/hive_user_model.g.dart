// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveUserModelAdapter extends TypeAdapter<HiveUserModel> {
  @override
  final int typeId = 0;

  @override
  HiveUserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveUserModel()
      ..uid = fields[0] as String?
      ..uidGroup = fields[1] as String?
      ..uidLeader = fields[2] as String?
      ..nama = fields[3] as String?
      ..email = fields[4] as String?
      ..password = fields[5] as String?
      ..group = fields[6] as String?
      ..lembaga = fields[7] as String?
      ..ponsel = fields[8] as String?
      ..amanah = fields[9] as String?;
  }

  @override
  void write(BinaryWriter writer, HiveUserModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.uidGroup)
      ..writeByte(2)
      ..write(obj.uidLeader)
      ..writeByte(3)
      ..write(obj.nama)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.password)
      ..writeByte(6)
      ..write(obj.group)
      ..writeByte(7)
      ..write(obj.lembaga)
      ..writeByte(8)
      ..write(obj.ponsel)
      ..writeByte(9)
      ..write(obj.amanah);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveUserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
