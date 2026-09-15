// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeling.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FeelingAdapter extends TypeAdapter<Feeling> {
  @override
  final typeId = 7;

  @override
  Feeling read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Feeling(
      id: fields[0] as String?,
      feelingName: fields[1] as String?,
      feelingDescription: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Feeling obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.feelingName)
      ..writeByte(2)
      ..write(obj.feelingDescription);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeelingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
