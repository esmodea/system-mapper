import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/front/front_entry.dart';
import 'package:system_mapper/data/hive_objects/system/member.dart';
import 'package:system_mapper/data/model_classes/base_model.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/data/model_classes/type_ids.dart';

part 'front.g.dart';

@HiveType(typeId: TypeIds.standardFront)
class StandardFront extends BaseModel {
  @override
  ModelType<StandardFront> get modelType => ModelType.standardFront;

  @override
  String get currentID => '424e60e1-ab58-446b-b8da-9aa4ca4cd503';

  @override
  @HiveField(0)
  String? id;

  @HiveField(1)
  List<Member>? membersInFront;

  @HiveField(2)
  List<FrontEntry>? activeFrontEntries;

  StandardFront({this.id, this.membersInFront, this.activeFrontEntries});

  @override
  void assignAttributes(Map<String, dynamic> map) {}

  @override
  Future<void> updateCurrent() async {
    await StandardFront(
      id: currentID,
      membersInFront: membersInFront ?? modelType.getCurrent()?.membersInFront,
      activeFrontEntries:
          activeFrontEntries ?? modelType.getCurrent()?.activeFrontEntries,
    ).save();
  }
}
