import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/regiments/regiment.dart';
import 'package:system_mapper/data/hive_objects/regiments/taken_entry.dart';
import 'package:system_mapper/data/model_classes/base_model.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/data/model_classes/type_ids.dart';

part 'regiment_archives.g.dart';

@HiveType(typeId: TypeIds.regimentArchive)
class RegimentArchive extends BaseModel {
  @override
  ModelType<RegimentArchive> get modelType =>
      ModelType.medicationRegimentArchive;

  @override
  String get currentID => 'd5addad8-4e6c-4a5c-a68e-7e0f21f6d868';

  @override
  @HiveField(0)
  String? id;

  @HiveField(1)
  Regiment? indefiniteRegiment;

  @HiveField(2)
  List<Regiment>? temporaryRegiments;

  @HiveField(3)
  List<TakenEntry>? timesTaken;

  RegimentArchive({
    this.id,
    this.indefiniteRegiment,
    this.temporaryRegiments,
    this.timesTaken,
  });

  @override
  void assignAttributes(Map<String, dynamic> map) {}

  @override
  Future<void> updateCurrent() async {
    await RegimentArchive(
      id: currentID,
      indefiniteRegiment:
          indefiniteRegiment ?? modelType.getCurrent()?.indefiniteRegiment,
      temporaryRegiments:
          temporaryRegiments ?? modelType.getCurrent()?.temporaryRegiments,
      timesTaken: timesTaken ?? modelType.getCurrent()?.timesTaken,
    ).save();
  }
}
