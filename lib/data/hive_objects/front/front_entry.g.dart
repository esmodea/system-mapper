// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'front_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FrontEntryAdapter extends TypeAdapter<FrontEntry> {
  @override
  final typeId = 3;

  @override
  FrontEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FrontEntry(
      id: fields[0] as String?,
      startTime: fields[1] as DateTime?,
      endTime: fields[2] as DateTime?,
      member: fields[3] as Member?,
    );
  }

  @override
  void write(BinaryWriter writer, FrontEntry obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.member);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FrontEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
