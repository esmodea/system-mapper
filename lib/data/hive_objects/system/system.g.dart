// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SystemAdapter extends TypeAdapter<System> {
  @override
  final typeId = 0;

  @override
  System read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return System(
      id: fields[0] as String?,
      membersList: (fields[1] as List?)?.cast<Member>(),
      systemName: fields[2] as String?,
      systemBio: fields[4] as String?,
      systemUUID: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, System obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.membersList)
      ..writeByte(2)
      ..write(obj.systemName)
      ..writeByte(3)
      ..write(obj.systemUUID)
      ..writeByte(4)
      ..write(obj.systemBio);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SystemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
