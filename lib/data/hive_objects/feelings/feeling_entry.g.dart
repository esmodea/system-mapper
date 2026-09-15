// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeling_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FeelingEntryAdapter extends TypeAdapter<FeelingEntry> {
  @override
  final typeId = 9;

  @override
  FeelingEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FeelingEntry(
      id: fields[0] as String?,
      feeling: fields[1] as Feeling?,
      entry: fields[2] as FrontEntry?,
    );
  }

  @override
  void write(BinaryWriter writer, FeelingEntry obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.feeling)
      ..writeByte(2)
      ..write(obj.entry);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeelingEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
