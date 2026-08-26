import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/front/front_entry.dart';
import 'package:system_mapper/data/hive_objects/member.dart';
import 'package:system_mapper/data/model_classes/base_model.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/data/model_classes/type_ids.dart';

part 'front.g.dart';

@HiveType(typeId: TypeIds.front)
class Front extends BaseModel {
  @override
  ModelType<Front> get modelType => ModelType.front;

  // TODO: Anonymise with a generated UUID
  @override
  String get currentID => 'current-front-id';

  @override
  @HiveField(0)
  String? id;

  @HiveField(1)
  List<Member>? membersInFront;

  @HiveField(2)
  List<FrontEntry>? activeFrontEntries;

  Front({this.id, this.membersInFront, this.activeFrontEntries});

  @override
  void assignAttributes(Map<String, dynamic> map) {}

  @override
  Future<void> updateCurrent() async {
    await Front(
      id: currentID,
      membersInFront: membersInFront ?? modelType.getCurrent()?.membersInFront,
      activeFrontEntries:
          activeFrontEntries ?? modelType.getCurrent()?.activeFrontEntries,
    ).save();
  }
}
