import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/front/front_entry.dart';
import 'package:system_mapper/data/model_classes/base_model.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/data/model_classes/type_ids.dart';

part 'front_archive.g.dart';

@HiveType(typeId: TypeIds.front)
class FrontArchive extends BaseModel {
  @override
  ModelType<FrontArchive> get modelType => ModelType.frontArchive;

  // TODO: Anonymise with a generated UUID
  @override
  String get currentID => 'current-front-id';

  @override
  @HiveField(0)
  String? id;

  @HiveField(1)
  List<FrontEntry>? archivedFrontEntries;

  FrontArchive({this.id, this.archivedFrontEntries});

  @override
  void assignAttributes(Map<String, dynamic> map) {}

  @override
  Future<void> updateCurrent() async {
    await FrontArchive(
      id: currentID,
      archivedFrontEntries:
          archivedFrontEntries ?? modelType.getCurrent()?.archivedFrontEntries,
    ).save();
  }
}
