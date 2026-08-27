// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MemberAdapter extends TypeAdapter<Member> {
  @override
  final typeId = 1;

  @override
  Member read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Member(
        id: fields[0] as String?,
        memberName: fields[1] as String?,
        memberBio: fields[2] as String?,
        frontEntries: (fields[3] as List?)?.cast<String>(),
        inFront: fields[4] as bool?,
      )
      ..avatarColor = fields[5] as Color?
      ..avatar = fields[6] as Uint8List?;
  }

  @override
  void write(BinaryWriter writer, Member obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.memberName)
      ..writeByte(2)
      ..write(obj.memberBio)
      ..writeByte(3)
      ..write(obj.frontEntries)
      ..writeByte(4)
      ..write(obj.inFront)
      ..writeByte(5)
      ..write(obj.avatarColor)
      ..writeByte(6)
      ..write(obj.avatar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemberAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
