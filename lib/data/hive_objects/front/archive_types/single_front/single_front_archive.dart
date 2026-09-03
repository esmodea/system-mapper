import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/front/front_entry.dart';
import 'package:system_mapper/data/model_classes/base_model.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/data/model_classes/type_ids.dart';

part 'single_front_archive.g.dart';

@HiveType(typeId: TypeIds.singleFrontArchive)
class SingleFrontArchive extends BaseModel {
  @override
  ModelType<SingleFrontArchive> get modelType => ModelType.singleFrontArchive;

  // TODO: Anonymise with a generated UUID
  @override
  String get currentID => 'current-single-front-archive-id';

  @override
  @HiveField(0)
  String? id;

  @HiveField(1)
  List<FrontEntry>? archivedFrontEntries;

  @HiveField(2)
  List<FrontEntry>? archivedConsciousnessEntries;

  SingleFrontArchive({
    this.id,
    this.archivedFrontEntries,
    this.archivedConsciousnessEntries,
  });

  @override
  void assignAttributes(Map<String, dynamic> map) {}

  @override
  Future<void> updateCurrent() async {
    await SingleFrontArchive(
      id: currentID,
      archivedFrontEntries:
          archivedFrontEntries ?? modelType.getCurrent()?.archivedFrontEntries,
      archivedConsciousnessEntries:
          archivedConsciousnessEntries ??
          modelType.getCurrent()?.archivedConsciousnessEntries,
    ).save();
  }
}
