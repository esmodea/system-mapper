import 'dart:ui';

import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/front/archive_types/single_front/single_front.dart';
import 'package:system_mapper/data/hive_objects/front/archive_types/single_front/single_front_archive.dart';
import 'package:system_mapper/data/hive_objects/front/archive_types/standard/front.dart';
import 'package:system_mapper/data/hive_objects/front/archive_types/standard/front_archive.dart';
import 'package:system_mapper/data/hive_objects/system/member.dart';
import 'package:system_mapper/data/hive_objects/system/system_front_type.dart';
import 'package:system_mapper/data/model_classes/base_model.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/data/model_classes/type_ids.dart';
import 'package:system_mapper/utils/current.dart';

part 'system.g.dart';

@HiveType(typeId: TypeIds.system)
class System extends BaseModel {
  @override
  ModelType<System> get modelType => ModelType.system;

  // TODO: Anonymise with a generated UUID
  @override
  String get currentID => 'current-system-id';

  @override
  @HiveField(0)
  String? id;

  @HiveField(1)
  List<Member>? membersList;

  @HiveField(2)
  String? systemName;

  @HiveField(3)
  String? systemUUID;

  @HiveField(4)
  String? systemBio;

  @HiveField(5)
  Color? systemColor;

  //TODO: Avatar property
  // @HiveField(6)
  // Uint8List? avatarImage;

  @HiveField(7)
  String? frontTypeString;

  @HiveField(8)
  StandardFrontArchive? standardFrontArchive;

  @HiveField(9)
  SingleFrontArchive? trackSingleFrontArchive;

  @HiveField(10)
  StandardFrontArchive? trackMultipleFrontsArchive;

  @HiveField(11)
  StandardFrontArchive? trackSingleFrontNoCoConsciousArchive;

  @HiveField(12)
  StandardFrontArchive? trackMultipleFrontsNoCoConsciousArchive;

  @HiveField(13)
  StandardFront? standardFront;

  @HiveField(14)
  SingleFront? trackSingleFront;

  @HiveField(15)
  StandardFront? trackMultipleFronts;

  @HiveField(16)
  StandardFront? trackSingleFrontNoCoConscious;

  @HiveField(17)
  StandardFront? trackMultipleFrontsNoCoConscious;

  System({
    this.id,
    this.membersList,
    this.systemName,
    this.systemBio,
    this.systemUUID,
    this.frontTypeString,
    this.standardFront,
    this.standardFrontArchive,
    this.trackSingleFront,
    this.trackSingleFrontArchive,
  });

  @override
  void assignAttributes(Map<String, dynamic> map) {}

  @override
  Future<void> updateCurrent() async {
    await System(
      id: currentID,
      membersList: membersList ?? modelType.getCurrent()?.membersList,
      systemBio: systemBio ?? modelType.getCurrent()?.systemBio,
      systemName: systemName ?? modelType.getCurrent()?.systemName,
      systemUUID: systemUUID ?? modelType.getCurrent()?.systemUUID,
      frontTypeString:
          frontTypeString ?? modelType.getCurrent()?.frontTypeString,
    ).save();
  }

  Future<void> saveSafely() async {
    await System(
      id: id,
      membersList: membersList ?? modelType.appBox.getById(id)?.membersList,
      systemBio: systemBio ?? modelType.appBox.getById(id)?.systemBio,
      systemName: systemName ?? modelType.appBox.getById(id)?.systemName,
      systemUUID: systemUUID ?? modelType.appBox.getById(id)?.systemUUID,
      frontTypeString:
          frontTypeString ?? modelType.appBox.getById(id)?.frontTypeString,
      standardFront: Current.standardFront,
      trackSingleFront: Current.singleFront,
      standardFrontArchive: Current.standardFrontArchive,
      trackSingleFrontArchive: Current.singleFrontArchive,
    ).save();
  }

  SystemFrontType get frontType =>
      SystemFrontType.parse(frontTypeString ?? 'onlyTrackFront');
}
