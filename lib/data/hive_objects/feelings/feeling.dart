import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/model_classes/base_model.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/data/model_classes/type_ids.dart';
import 'package:system_mapper/utils/current.dart';

part 'feeling.g.dart';

@HiveType(typeId: TypeIds.feeling)
class Feeling extends BaseModel {
  @override
  ModelType<Feeling> get modelType => ModelType.feeling;

  @override
  String? get currentID => null;

  // TO DO: Anonymise with a generated UUID
  // static const String currentSystemID = 'current-member-id';

  @override
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? feelingName;

  @HiveField(2)
  String? feelingDescription;

  @HiveField(3)
  String? feelingParentName;

  @HiveField(4)
  String? emojiCode;

  Feeling({
    this.id,
    this.feelingName,
    this.feelingDescription,
    this.feelingParentName,
    this.emojiCode,
  });

  @override
  void assignAttributes(Map<String, dynamic> map) {}

  static Feeling? getFeeling(String? insertedFeelingName) {
    Feeling? feeling;
    feeling = Current.feelings?.firstOrderFeelings
        ?.map((feeling) {
          if (feeling.feelingName == (insertedFeelingName ?? '')) {
            return feeling;
          }
        })
        .toList()
        .where((feeling) => feeling != null)
        .firstOrNull;
    feeling ??= Current.feelings?.secondOrderFeelings
        ?.map((feeling) {
          if (feeling.feelingName == (insertedFeelingName ?? '')) {
            return feeling;
          }
        })
        .toList()
        .where((feeling) => feeling != null)
        .firstOrNull;
    feeling ??= Current.feelings?.thirdOrderFeelings
        ?.map((feeling) {
          if (feeling.feelingName == (insertedFeelingName ?? '')) {
            return feeling;
          }
        })
        .toList()
        .where((feeling) => feeling != null)
        .firstOrNull;
    return feeling;
  }
}
