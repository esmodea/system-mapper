// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taken_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TakenEntryAdapter extends TypeAdapter<TakenEntry> {
  @override
  final typeId = 2003;

  @override
  TakenEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TakenEntry(
      id: fields[0] as String?,
      medicationName: fields[1] as String?,
      milligrams: (fields[2] as num?)?.toInt(),
      targetTime: fields[3] as DateTime?,
      timeTaken: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, TakenEntry obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.medicationName)
      ..writeByte(2)
      ..write(obj.milligrams)
      ..writeByte(3)
      ..write(obj.targetTime)
      ..writeByte(4)
      ..write(obj.timeTaken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TakenEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
