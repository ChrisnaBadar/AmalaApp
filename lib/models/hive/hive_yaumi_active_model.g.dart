// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_yaumi_active_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveYaumiActiveModelAdapter extends TypeAdapter<HiveYaumiActiveModel> {
  @override
  final int typeId = 1;

  @override
  HiveYaumiActiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveYaumiActiveModel()
      ..fardhu = fields[0] as bool?
      ..tahajud = fields[1] as bool?
      ..dhuha = fields[2] as bool?
      ..rawatib = fields[3] as bool?
      ..tilawah = fields[4] as bool?
      ..shaum = fields[5] as bool?
      ..sedekah = fields[6] as bool?
      ..dzikir = fields[7] as bool?
      ..taklim = fields[8] as bool?
      ..istighfar = fields[9] as bool?
      ..shalawat = fields[10] as bool?;
  }

  @override
  void write(BinaryWriter writer, HiveYaumiActiveModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.fardhu)
      ..writeByte(1)
      ..write(obj.tahajud)
      ..writeByte(2)
      ..write(obj.dhuha)
      ..writeByte(3)
      ..write(obj.rawatib)
      ..writeByte(4)
      ..write(obj.tilawah)
      ..writeByte(5)
      ..write(obj.shaum)
      ..writeByte(6)
      ..write(obj.sedekah)
      ..writeByte(7)
      ..write(obj.dzikir)
      ..writeByte(8)
      ..write(obj.taklim)
      ..writeByte(9)
      ..write(obj.istighfar)
      ..writeByte(10)
      ..write(obj.shalawat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveYaumiActiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
