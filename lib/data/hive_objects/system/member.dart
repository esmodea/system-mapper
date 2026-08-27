import 'dart:typed_data';
import 'dart:ui';

import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/front/front.dart';
import 'package:system_mapper/data/hive_objects/front/front_archive.dart';
import 'package:system_mapper/data/hive_objects/front/front_entry.dart';
import 'package:system_mapper/data/hive_objects/system/system.dart';
import 'package:system_mapper/data/model_classes/base_model.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/data/model_classes/type_ids.dart';
import 'package:system_mapper/utils/current.dart';
import 'package:uuid/uuid.dart';

part 'member.g.dart';

@HiveType(typeId: TypeIds.member)
class Member extends BaseModel {
  @override
  ModelType<Member> get modelType => ModelType.member;

  @override
  String? get currentID => null;

  // TO DO: Anonymise with a generated UUID
  // static const String currentSystemID = 'current-member-id';

  @override
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? memberName;

  @HiveField(2)
  String? memberBio;

  @HiveField(3)
  List<String>? frontEntries;

  @HiveField(4)
  bool? inFront;

  @HiveField(5)
  Color? avatarColor;

  @HiveField(6)
  Uint8List? avatar;

  Member({
    this.id,
    this.memberName,
    this.memberBio,
    this.frontEntries,
    this.inFront,
  });

  @override
  void assignAttributes(Map<String, dynamic> map) {}

  Future<void> addToFront() async {
    String frontEntryUUID = Uuid().v6();
    String memberUUID = Uuid().v5(Namespace.url.value, memberName);
    FrontEntry newFrontEntry = FrontEntry(
      id: memberUUID + frontEntryUUID,
      startTime: DateTime.now(),
      member: this,
      frontEntryUUID: frontEntryUUID,
      memberUUID: memberUUID,
    );
    newFrontEntry.save();
    if (!(inFront ?? inFrontCheck())) {
      await Front(
        membersInFront: [...Current.front?.membersInFront ?? [], this],
        activeFrontEntries: [
          ...Current.front?.activeFrontEntries ?? [],
          newFrontEntry,
        ],
      ).updateCurrent();
    }
    updateCurrent();
  }

  Future<void> removeFromFront() async {
    List<Member> newFrontList = Current.front?.membersInFront ?? [];
    List<FrontEntry> newFrontEntryList =
        Current.front?.activeFrontEntries ?? [];
    newFrontList.removeWhere((member) => member.memberName == memberName);
    int index = newFrontEntryList.indexWhere(
      (entry) => entry.memberUUID == Uuid().v5(Namespace.url.value, memberName),
    );
    if (index >= 0) {
      FrontEntry extractedEntry = newFrontEntryList.elementAt(index);
      FrontEntry finalizedEntry = FrontEntry(
        id: extractedEntry.id,
        startTime: extractedEntry.startTime,
        endTime: DateTime.now(),
        member: extractedEntry.member,
        memberUUID: extractedEntry.memberUUID,
        frontEntryUUID: extractedEntry.frontEntryUUID,
      );
      finalizedEntry.save();
      newFrontEntryList.removeAt(index);
      await FrontArchive(
        archivedFrontEntries: [
          ...Current.frontArchive?.archivedFrontEntries ?? [],
          finalizedEntry,
        ],
      ).updateCurrent();
    }
    await Front(
      membersInFront: newFrontList,
      activeFrontEntries: newFrontEntryList,
    ).updateCurrent();
  }

  bool inFrontCheck() {
    return (Current.front?.membersInFront?.indexWhere(
          (member) => member.memberName == memberName,
        ) !=
        -1);
  }

  @override
  Future<void> updateCurrent() async {
    List<Member>? members = Current.system?.membersList;
    int index =
        members?.indexWhere((member) => member.memberName == memberName) ?? -1;
    if (index >= 0) {
      Member newMember = Member(
        memberName: memberName,
        memberBio: memberBio,
        frontEntries: frontEntries,
        inFront: inFront,
      );
      members![index] = newMember;
      System(membersList: members).saveSafely();
    }
  }
}
