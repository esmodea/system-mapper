import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/front/archive_types/single_front/single_front.dart';
import 'package:system_mapper/data/hive_objects/front/archive_types/single_front/single_front_archive.dart';
import 'package:system_mapper/data/hive_objects/front/archive_types/standard/front.dart';
import 'package:system_mapper/data/hive_objects/front/archive_types/standard/front_archive.dart';
import 'package:system_mapper/data/hive_objects/front/front_entry.dart';
import 'package:system_mapper/data/hive_objects/system/system.dart';
import 'package:system_mapper/data/hive_objects/system/system_front_type.dart';
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

  // @HiveField(4)
  // bool? inFront;

  @HiveField(5)
  Color? avatarColor;

  @HiveField(6)
  Uint8List? avatar;

  Member({
    this.id,
    this.memberName,
    this.memberBio,
    this.frontEntries,
    // this.inFront,
    this.avatarColor,
    this.avatar,
  });

  @override
  void assignAttributes(Map<String, dynamic> map) {}

  Future<void> addToStandardFront() async {
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
    if (!(inFrontCheck())) {
      await StandardFront(
        membersInFront: [...Current.standardFront?.membersInFront ?? [], this],
        activeFrontEntries: [
          ...Current.standardFront?.activeFrontEntries ?? [],
          newFrontEntry,
        ],
      ).updateCurrent();
    }
    updateCurrent();
  }

  Future<void> removeFromStandardFront() async {
    List<Member> newFrontList = Current.standardFront?.membersInFront ?? [];
    List<FrontEntry> newFrontEntryList =
        Current.standardFront?.activeFrontEntries ?? [];
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
      await StandardFrontArchive(
        archivedFrontEntries: [
          ...Current.standardFrontArchive?.archivedFrontEntries ?? [],
          finalizedEntry,
        ],
      ).updateCurrent();
    }
    await StandardFront(
      membersInFront: newFrontList,
      activeFrontEntries: newFrontEntryList,
    ).updateCurrent();
  }

  Future<void> addToSingleFront() async {
    String frontEntryUUID = Uuid().v6();
    String memberUUID = Uuid().v5(Namespace.url.value, memberName);
    FrontEntry newFrontEntry = FrontEntry(
      id: memberUUID + frontEntryUUID,
      startTime: DateTime.now(),
      member: this,
      frontEntryUUID: frontEntryUUID,
      memberUUID: memberUUID,
      isOnlyConscious: null,
    );
    newFrontEntry.save();
    if (!(inFrontCheck()) &&
        (Current.singleFront?.membersInFront?.isEmpty ?? true)) {
      await SingleFront(
        membersInFront: [this],
        activeFrontEntries: [newFrontEntry],
      ).updateCurrent();
    } else if (!(consciousCheck())) {
      await SingleFront(
        membersConscious: [
          ...Current.singleFront?.membersConscious ?? [],
          this,
        ],
        activeConsciousnessEntries: [
          ...Current.singleFront?.activeConsciousnessEntries ?? [],
          newFrontEntry,
        ],
      ).updateCurrent();
    }
    updateCurrent();
  }

  Future<void> removeFromSingleFront() async {
    // Handle Front
    List<Member> newFrontList = Current.singleFront?.membersInFront ?? [];
    List<FrontEntry> newFrontEntryList =
        Current.singleFront?.activeFrontEntries ?? [];
    if (newFrontList.isNotEmpty && inFrontCheck()) {
      newFrontList.removeWhere((member) => member.memberName == memberName);
    }
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
        isOnlyConscious: extractedEntry.isOnlyConscious ?? false,
      );
      finalizedEntry.save();
      await SingleFrontArchive(
        archivedFrontEntries: [
          ...Current.singleFrontArchive?.archivedFrontEntries ?? [],
          finalizedEntry,
        ],
      ).updateCurrent();
      newFrontEntryList.removeAt(index);
    }
    await SingleFront(
      membersInFront: newFrontList,
      activeFrontEntries: newFrontEntryList,
    ).updateCurrent();
    // Handle Consciousness
    List<Member> newConsciousList = Current.singleFront?.membersConscious ?? [];
    List<FrontEntry> newConsciousFrontEntryList =
        Current.singleFront?.activeConsciousnessEntries ?? [];
    newConsciousList.removeWhere((member) => member.memberName == memberName);
    int consciousnessIndex = newConsciousFrontEntryList.indexWhere((entry) {
      debugPrint(entry.memberUUID);
      debugPrint(Uuid().v5(Namespace.url.value, memberName));
      return entry.memberUUID == Uuid().v5(Namespace.url.value, memberName);
    });
    if (consciousnessIndex >= 0) {
      FrontEntry extractedEntry = newConsciousFrontEntryList.elementAt(
        consciousnessIndex,
      );
      FrontEntry finalizedEntry = FrontEntry(
        id: extractedEntry.id,
        startTime: extractedEntry.startTime,
        endTime: DateTime.now(),
        member: extractedEntry.member,
        memberUUID: extractedEntry.memberUUID,
        frontEntryUUID: extractedEntry.frontEntryUUID,
        isOnlyConscious: extractedEntry.isOnlyConscious ?? true,
      );
      finalizedEntry.save();
      debugPrint(finalizedEntry.endTime.toString());
      await SingleFrontArchive(
        archivedConsciousnessEntries: [
          ...Current.singleFrontArchive?.archivedConsciousnessEntries ?? [],
          finalizedEntry,
        ],
      ).updateCurrent();
      newConsciousFrontEntryList.removeAt(consciousnessIndex);
      debugPrint(
        [
          ...Current.singleFrontArchive?.archivedConsciousnessEntries ?? [],
          finalizedEntry,
        ].toString(),
      );
    }
    await SingleFront(
      membersConscious: newConsciousList,
      activeConsciousnessEntries: newConsciousFrontEntryList,
    ).updateCurrent();
  }

  bool inFrontCheck() {
    if (Current.system?.frontType == SystemFrontType.onlyTrackFront) {
      return (Current.standardFront?.membersInFront?.indexWhere(
            (member) => member.memberName == memberName,
          ) !=
          -1);
    } else {
      return (Current.singleFront?.membersInFront?.indexWhere(
            (member) => member.memberName == memberName,
          ) !=
          -1);
    }
  }

  bool consciousCheck() {
    return (Current.singleFront?.membersConscious?.indexWhere(
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
        // inFront: inFrontCheck(),
        avatar: avatar,
        avatarColor: avatarColor,
      );
      members![index] = newMember;
      System(membersList: members).saveSafely();
    }
  }
}
