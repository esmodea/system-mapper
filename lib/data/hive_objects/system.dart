import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/member.dart';
import 'package:system_mapper/data/model_classes/base_model.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/data/model_classes/type_ids.dart';

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

  //TODO: Avatar property

  System({
    this.id,
    this.membersList,
    this.systemName,
    this.systemBio,
    this.systemUUID,
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
    ).save();
  }

  Future<void> saveSafely() async {
    await System(
      id: id,
      membersList: membersList ?? modelType.appBox?.getById(id)?.membersList,
      systemBio: systemBio ?? modelType.appBox?.getById(id)?.systemBio,
      systemName: systemName ?? modelType.appBox?.getById(id)?.systemName,
      systemUUID: systemUUID ?? modelType.appBox?.getById(id)?.systemUUID,
    ).save();
  }
}
