// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'front_archive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StandardFrontArchiveAdapter extends TypeAdapter<StandardFrontArchive> {
  @override
  final typeId = 4;

  @override
  StandardFrontArchive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StandardFrontArchive(
      id: fields[0] as String?,
      archivedFrontEntries: (fields[1] as List?)?.cast<FrontEntry>(),
    );
  }

  @override
  void write(BinaryWriter writer, StandardFrontArchive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.archivedFrontEntries);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StandardFrontArchiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
