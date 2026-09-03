import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/front/archive_types/single_front/single_front.dart';
import 'package:system_mapper/data/hive_objects/front/archive_types/standard/front.dart';
import 'package:system_mapper/data/hive_objects/system/member.dart';
import 'package:system_mapper/data/model_classes/base_model.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/data/model_classes/type_ids.dart';
import 'package:system_mapper/utils/current.dart';

part 'front_entry.g.dart';

@HiveType(typeId: TypeIds.frontEntry)
class FrontEntry extends BaseModel {
  @override
  ModelType<FrontEntry> get modelType => ModelType.frontEntry;

  @override
  String? get currentID => null;

  @override
  @HiveField(0)
  String? id;

  @HiveField(1)
  DateTime? startTime;

  @HiveField(2)
  DateTime? endTime;

  @HiveField(3)
  Member? member;

  @HiveField(4)
  String? frontEntryUUID;

  @HiveField(5)
  String? memberUUID;

  @HiveField(6)
  bool? isOnlyConscious;

  FrontEntry({
    this.id,
    this.startTime,
    this.endTime,
    this.member,
    this.frontEntryUUID,
    this.memberUUID,
    this.isOnlyConscious,
  });

  @override
  void assignAttributes(Map<String, dynamic> map) {}

  Future<void> addToStandardFront() async {
    if (startTime != null && frontEntryUUID != null && member != null) {
      await StandardFront(
        activeFrontEntries: [
          ...Current.standardFront?.activeFrontEntries ?? [],
          this,
        ],
      ).updateCurrent();
    } else {
      throw ArgumentError.notNull();
    }
  }

  Future<void> removeFromStandardFront() async {
    if (startTime != null &&
        endTime != null &&
        frontEntryUUID != null &&
        member != null) {
      List<FrontEntry> newFrontList =
          Current.standardFront?.activeFrontEntries ?? [];
      newFrontList.removeWhere(
        (entry) => entry.frontEntryUUID == frontEntryUUID,
      );
      await StandardFront(activeFrontEntries: newFrontList).updateCurrent();
    } else {
      throw ArgumentError.notNull();
    }
  }

  Future<void> addToSingleFront() async {
    if (startTime != null && frontEntryUUID != null && member != null) {
      await SingleFront(activeFrontEntries: [this]).updateCurrent();
    } else {
      throw ArgumentError.notNull();
    }
  }

  Future<void> removeFromSingleFront() async {
    if (startTime != null &&
        endTime != null &&
        frontEntryUUID != null &&
        member != null) {
      await SingleFront(activeFrontEntries: []).updateCurrent();
    } else {
      throw ArgumentError.notNull();
    }
  }

  Future<void> addToConsciousness() async {
    if (startTime != null && frontEntryUUID != null && member != null) {
      await SingleFront(
        activeFrontEntries: [
          ...Current.singleFront?.activeFrontEntries ?? [],
          this,
        ],
      ).updateCurrent();
    } else {
      throw ArgumentError.notNull();
    }
  }

  Future<void> removeFromConsciousness() async {
    if (startTime != null &&
        endTime != null &&
        frontEntryUUID != null &&
        member != null) {
      List<FrontEntry> newConsciousnessList =
          Current.singleFront?.activeFrontEntries ?? [];
      newConsciousnessList.removeWhere(
        (entry) => entry.frontEntryUUID == frontEntryUUID,
      );
      await SingleFront(
        activeConsciousnessEntries: newConsciousnessList,
      ).updateCurrent();
    } else {
      throw ArgumentError.notNull();
    }
  }
}
