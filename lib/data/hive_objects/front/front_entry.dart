import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/front/front.dart';
import 'package:system_mapper/data/hive_objects/member.dart';
import 'package:system_mapper/data/model_classes/base_model.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/data/model_classes/type_ids.dart';

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

  FrontEntry({this.id, this.startTime, this.endTime, this.member});

  @override
  void assignAttributes(Map<String, dynamic> map) {}

  Future<void> addToFront() async {
    await Front().updateCurrent();
  }

  Future<void> removeFromFront() async {
    await Front().updateCurrent();
  }
}
