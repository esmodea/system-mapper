// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_front.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SingleFrontAdapter extends TypeAdapter<SingleFront> {
  @override
  final typeId = 6;

  @override
  SingleFront read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SingleFront(
      id: fields[0] as String?,
      membersInFront: (fields[1] as List?)?.cast<Member>(),
      activeFrontEntries: (fields[2] as List?)?.cast<FrontEntry>(),
      activeConsciousnessEntries: (fields[3] as List?)?.cast<FrontEntry>(),
      membersConscious: (fields[4] as List?)?.cast<Member>(),
    );
  }

  @override
  void write(BinaryWriter writer, SingleFront obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.membersInFront)
      ..writeByte(2)
      ..write(obj.activeFrontEntries)
      ..writeByte(3)
      ..write(obj.activeConsciousnessEntries)
      ..writeByte(4)
      ..write(obj.membersConscious);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SingleFrontAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
