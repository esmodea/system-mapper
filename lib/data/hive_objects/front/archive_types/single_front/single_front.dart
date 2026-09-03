import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/front/front_entry.dart';
import 'package:system_mapper/data/hive_objects/system/member.dart';
import 'package:system_mapper/data/model_classes/base_model.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/data/model_classes/type_ids.dart';

part 'single_front.g.dart';

@HiveType(typeId: TypeIds.singleFront)
class SingleFront extends BaseModel {
  @override
  ModelType<SingleFront> get modelType => ModelType.singleFront;

  // TODO: Anonymise with a generated UUID
  @override
  String get currentID => 'current-single-front-id';

  @override
  @HiveField(0)
  String? id;

  @HiveField(1)
  List<Member>? membersInFront;

  @HiveField(2)
  List<FrontEntry>? activeFrontEntries;

  @HiveField(3)
  List<FrontEntry>? activeConsciousnessEntries;

  @HiveField(4)
  List<Member>? membersConscious;

  SingleFront({
    this.id,
    this.membersInFront,
    this.activeFrontEntries,
    this.activeConsciousnessEntries,
    this.membersConscious,
  });

  @override
  void assignAttributes(Map<String, dynamic> map) {}

  @override
  Future<void> updateCurrent() async {
    await SingleFront(
      id: currentID,
      membersInFront: membersInFront ?? modelType.getCurrent()?.membersInFront,
      membersConscious:
          membersConscious ?? modelType.getCurrent()?.membersConscious,
      activeFrontEntries:
          activeFrontEntries ?? modelType.getCurrent()?.activeFrontEntries,
      activeConsciousnessEntries:
          activeConsciousnessEntries ??
          modelType.getCurrent()?.activeConsciousnessEntries,
    ).save();
  }
}
