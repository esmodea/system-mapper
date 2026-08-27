import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/front/front.dart';
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

  FrontEntry({
    this.id,
    this.startTime,
    this.endTime,
    this.member,
    this.frontEntryUUID,
    this.memberUUID,
  });

  @override
  void assignAttributes(Map<String, dynamic> map) {}

  Future<void> addToFront() async {
    if (startTime != null && frontEntryUUID != null && member != null) {
      await Front(
        activeFrontEntries: [...Current.front?.activeFrontEntries ?? [], this],
      ).updateCurrent();
    } else {
      throw ArgumentError.notNull();
    }
  }

  Future<void> removeFromFront() async {
    if (startTime != null &&
        endTime != null &&
        frontEntryUUID != null &&
        member != null) {
      List<FrontEntry> newFrontList = Current.front?.activeFrontEntries ?? [];
      newFrontList.removeWhere(
        (entry) => entry.frontEntryUUID == frontEntryUUID,
      );
      await Front(activeFrontEntries: newFrontList).updateCurrent();
    } else {
      throw ArgumentError.notNull();
    }
  }
}
