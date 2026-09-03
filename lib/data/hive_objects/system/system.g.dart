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
        frontTypeString: fields[7] as String?,
        standardFront: fields[13] as StandardFront?,
        standardFrontArchive: fields[8] as StandardFrontArchive?,
        trackSingleFront: fields[14] as SingleFront?,
        trackSingleFrontArchive: fields[9] as SingleFrontArchive?,
      )
      ..systemColor = fields[5] as Color?
      ..trackMultipleFrontsArchive = fields[10] as StandardFrontArchive?
      ..trackSingleFrontNoCoConsciousArchive =
          fields[11] as StandardFrontArchive?
      ..trackMultipleFrontsNoCoConsciousArchive =
          fields[12] as StandardFrontArchive?
      ..trackMultipleFronts = fields[15] as StandardFront?
      ..trackSingleFrontNoCoConscious = fields[16] as StandardFront?
      ..trackMultipleFrontsNoCoConscious = fields[17] as StandardFront?;
  }

  @override
  void write(BinaryWriter writer, System obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.membersList)
      ..writeByte(2)
      ..write(obj.systemName)
      ..writeByte(3)
      ..write(obj.systemUUID)
      ..writeByte(4)
      ..write(obj.systemBio)
      ..writeByte(5)
      ..write(obj.systemColor)
      ..writeByte(7)
      ..write(obj.frontTypeString)
      ..writeByte(8)
      ..write(obj.standardFrontArchive)
      ..writeByte(9)
      ..write(obj.trackSingleFrontArchive)
      ..writeByte(10)
      ..write(obj.trackMultipleFrontsArchive)
      ..writeByte(11)
      ..write(obj.trackSingleFrontNoCoConsciousArchive)
      ..writeByte(12)
      ..write(obj.trackMultipleFrontsNoCoConsciousArchive)
      ..writeByte(13)
      ..write(obj.standardFront)
      ..writeByte(14)
      ..write(obj.trackSingleFront)
      ..writeByte(15)
      ..write(obj.trackMultipleFronts)
      ..writeByte(16)
      ..write(obj.trackSingleFrontNoCoConscious)
      ..writeByte(17)
      ..write(obj.trackMultipleFrontsNoCoConscious);
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
