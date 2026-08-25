// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'front.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FrontAdapter extends TypeAdapter<Front> {
  @override
  final typeId = 2;

  @override
  Front read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Front(
      id: fields[0] as String?,
      membersInFront: (fields[1] as List?)?.cast<Member>(),
    );
  }

  @override
  void write(BinaryWriter writer, Front obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.membersInFront);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FrontAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
