import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/model_classes/base_model.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/data/model_classes/type_ids.dart';

part 'taken_entry.g.dart';

@HiveType(typeId: TypeIds.takenEntry)
class TakenEntry extends BaseModel {
  @override
  ModelType<TakenEntry> get modelType => ModelType.takenEntry;

  @override
  String? get currentID => throw UnimplementedError();

  @override
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? medicationName;

  @HiveField(2)
  int? milligrams;

  @HiveField(3)
  DateTime? targetTime;

  @HiveField(4)
  DateTime? timeTaken;

  TakenEntry({
    this.id,
    this.medicationName,
    this.milligrams,
    this.targetTime,
    this.timeTaken,
  });

  @override
  void assignAttributes(Map<String, dynamic> map) {}

  @override
  Future<void> updateCurrent() async {
    //TODO: Implement updateCurrent()
  }

  Duration get targetOffset => targetTime!.difference(timeTaken!);

  bool get isAfter => targetOffset.isNegative;
}
