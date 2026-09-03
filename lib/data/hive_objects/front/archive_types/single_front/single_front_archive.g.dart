// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_front_archive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SingleFrontArchiveAdapter extends TypeAdapter<SingleFrontArchive> {
  @override
  final typeId = 5;

  @override
  SingleFrontArchive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SingleFrontArchive(
      id: fields[0] as String?,
      archivedFrontEntries: (fields[1] as List?)?.cast<FrontEntry>(),
      archivedConsciousnessEntries: (fields[2] as List?)?.cast<FrontEntry>(),
    );
  }

  @override
  void write(BinaryWriter writer, SingleFrontArchive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.archivedFrontEntries)
      ..writeByte(2)
      ..write(obj.archivedConsciousnessEntries);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SingleFrontArchiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
