import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/model_classes/base_model.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/data/model_classes/type_ids.dart';

part 'member.g.dart';

@HiveType(typeId: TypeIds.member)
class Member extends BaseModel {
  @override
  ModelType<Member> get modelType => ModelType.member;

  @override
  String? get currentID => null;

  // TO DO: Anonymise with a generated UUID
  // static const String currentSystemID = 'current-member-id';

  @override
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? memberName;

  @HiveField(2)
  String? memberBio;

  Member({this.id, this.memberName, this.memberBio});

  @override
  void assignAttributes(Map<String, dynamic> map) {}
}
