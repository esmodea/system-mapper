import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/front/front_entry.dart';
import 'package:system_mapper/data/model_classes/base_model.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/data/model_classes/type_ids.dart';

part 'front_archive.g.dart';

@HiveType(typeId: TypeIds.standardFrontArchive)
class StandardFrontArchive extends BaseModel {
  @override
  ModelType<StandardFrontArchive> get modelType =>
      ModelType.standardFrontArchive;

  @override
  String get currentID => 'a8d73df7-f545-4b8e-843e-44a83c117318';

  @override
  @HiveField(0)
  String? id;

  @HiveField(1)
  List<FrontEntry>? archivedFrontEntries;

  StandardFrontArchive({this.id, this.archivedFrontEntries});

  @override
  void assignAttributes(Map<String, dynamic> map) {}

  @override
  Future<void> updateCurrent() async {
    await StandardFrontArchive(
      id: currentID,
      archivedFrontEntries:
          archivedFrontEntries ?? modelType.getCurrent()?.archivedFrontEntries,
    ).save();
  }
}
