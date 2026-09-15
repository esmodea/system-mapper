// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feelings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FeelingsListAdapter extends TypeAdapter<FeelingsList> {
  @override
  final typeId = 8;

  @override
  FeelingsList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FeelingsList(
      id: fields[0] as String?,
      firstOrderFeelings: (fields[1] as List?)?.cast<Feeling>(),
      secondOrderFeelings: (fields[2] as List?)?.cast<Feeling>(),
      thirdOrderFeelings: (fields[3] as List?)?.cast<Feeling>(),
    );
  }

  @override
  void write(BinaryWriter writer, FeelingsList obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstOrderFeelings)
      ..writeByte(2)
      ..write(obj.secondOrderFeelings)
      ..writeByte(3)
      ..write(obj.thirdOrderFeelings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeelingsListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
