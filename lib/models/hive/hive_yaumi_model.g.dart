// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_yaumi_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveYaumiModelAdapter extends TypeAdapter<HiveYaumiModel> {
  @override
  final int typeId = 2;

  @override
  HiveYaumiModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveYaumiModel()
      ..tanggal = fields[0] as DateTime?
      ..shubuh = fields[1] as bool?
      ..dhuhur = fields[2] as bool?
      ..ashar = fields[3] as bool?
      ..maghrib = fields[4] as bool?
      ..isya = fields[5] as bool?
      ..tahajud = fields[6] as bool?
      ..dhuha = fields[7] as bool?
      ..rawatib = fields[8] as bool?
      ..tilawah = fields[9] as bool?
      ..shaum = fields[10] as bool?
      ..sedekah = fields[11] as bool?
      ..dzikirPagi = fields[12] as bool?
      ..dzikirPetang = fields[13] as bool?
      ..taklim = fields[14] as bool?
      ..istighfar = fields[15] as bool?
      ..shalawat = fields[16] as bool?
      ..isSaved = fields[17] as bool?
      ..point = fields[18] as double?;
  }

  @override
  void write(BinaryWriter writer, HiveYaumiModel obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.tanggal)
      ..writeByte(1)
      ..write(obj.shubuh)
      ..writeByte(2)
      ..write(obj.dhuhur)
      ..writeByte(3)
      ..write(obj.ashar)
      ..writeByte(4)
      ..write(obj.maghrib)
      ..writeByte(5)
      ..write(obj.isya)
      ..writeByte(6)
      ..write(obj.tahajud)
      ..writeByte(7)
      ..write(obj.dhuha)
      ..writeByte(8)
      ..write(obj.rawatib)
      ..writeByte(9)
      ..write(obj.tilawah)
      ..writeByte(10)
      ..write(obj.shaum)
      ..writeByte(11)
      ..write(obj.sedekah)
      ..writeByte(12)
      ..write(obj.dzikirPagi)
      ..writeByte(13)
      ..write(obj.dzikirPetang)
      ..writeByte(14)
      ..write(obj.taklim)
      ..writeByte(15)
      ..write(obj.istighfar)
      ..writeByte(16)
      ..write(obj.shalawat)
      ..writeByte(17)
      ..write(obj.isSaved)
      ..writeByte(18)
      ..write(obj.point);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveYaumiModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
