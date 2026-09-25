// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regiment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegimentAdapter extends TypeAdapter<Regiment> {
  @override
  final typeId = 2001;

  @override
  Regiment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Regiment(
      id: fields[0] as String?,
      regimentName: fields[1] as String?,
      medications: (fields[2] as List?)?.cast<Medication>(),
      endOfRegiment: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Regiment obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.regimentName)
      ..writeByte(2)
      ..write(obj.medications)
      ..writeByte(3)
      ..write(obj.endOfRegiment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegimentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
