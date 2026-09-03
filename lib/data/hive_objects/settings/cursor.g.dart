// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cursor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CursorAdapter extends TypeAdapter<Cursor> {
  @override
  final typeId = 1001;

  @override
  Cursor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cursor(
      id: fields[0] as String?,
      cursorX: (fields[1] as num?)?.toDouble(),
      cursorY: (fields[2] as num?)?.toDouble(),
      refreshRate: (fields[3] as num?)?.toInt(),
      windowWidth: (fields[4] as num?)?.toInt(),
      windowHeight: (fields[5] as num?)?.toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, Cursor obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.cursorX)
      ..writeByte(2)
      ..write(obj.cursorY)
      ..writeByte(3)
      ..write(obj.refreshRate)
      ..writeByte(4)
      ..write(obj.windowWidth)
      ..writeByte(5)
      ..write(obj.windowHeight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CursorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
