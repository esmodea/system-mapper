// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regiment_archives.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegimentArchiveAdapter extends TypeAdapter<RegimentArchive> {
  @override
  final typeId = 2002;

  @override
  RegimentArchive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegimentArchive(
      id: fields[0] as String?,
      indefiniteRegiment: fields[1] as Regiment?,
      temporaryRegiments: (fields[2] as List?)?.cast<Regiment>(),
      timesTaken: (fields[3] as List?)?.cast<TakenEntry>(),
    );
  }

  @override
  void write(BinaryWriter writer, RegimentArchive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.indefiniteRegiment)
      ..writeByte(2)
      ..write(obj.temporaryRegiments)
      ..writeByte(3)
      ..write(obj.timesTaken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegimentArchiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
