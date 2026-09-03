// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'front.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StandardFrontAdapter extends TypeAdapter<StandardFront> {
  @override
  final typeId = 2;

  @override
  StandardFront read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StandardFront(
      id: fields[0] as String?,
      membersInFront: (fields[1] as List?)?.cast<Member>(),
      activeFrontEntries: (fields[2] as List?)?.cast<FrontEntry>(),
    );
  }

  @override
  void write(BinaryWriter writer, StandardFront obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.membersInFront)
      ..writeByte(2)
      ..write(obj.activeFrontEntries);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StandardFrontAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
