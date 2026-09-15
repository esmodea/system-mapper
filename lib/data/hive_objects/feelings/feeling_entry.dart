import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/feelings/feeling.dart';
import 'package:system_mapper/data/hive_objects/front/front_entry.dart';
import 'package:system_mapper/data/model_classes/base_model.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/data/model_classes/type_ids.dart';

part 'feeling_entry.g.dart';

@HiveType(typeId: TypeIds.feelingEntry)
class FeelingEntry extends BaseModel {
  @override
  ModelType<FeelingEntry> get modelType => ModelType.feelingEntry;

  @override
  String? get currentID => null;

  // TO DO: Anonymise with a generated UUID
  // static const String currentSystemID = 'current-member-id';

  @override
  @HiveField(0)
  String? id;

  @HiveField(1)
  Feeling? feeling;

  @HiveField(2)
  FrontEntry? entry;

  FeelingEntry({this.id, this.feeling, this.entry});

  @override
  void assignAttributes(Map<String, dynamic> map) {}
}
