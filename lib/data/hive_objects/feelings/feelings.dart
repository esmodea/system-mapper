import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/feelings/feeling.dart';
import 'package:system_mapper/data/model_classes/base_model.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/data/model_classes/type_ids.dart';
import 'package:system_mapper/data/propagators/feeling_propagator.dart';
import 'package:system_mapper/utils/current.dart';

part 'feelings.g.dart';

@HiveType(typeId: TypeIds.feelings)
class FeelingsList extends BaseModel {
  @override
  ModelType<FeelingsList> get modelType => ModelType.feelings;

  @override
  String? get currentID => '7e0358c9-4b11-402c-916f-59a48185126c';

  @override
  @HiveField(0)
  String? id;

  @HiveField(1)
  List<Feeling>? firstOrderFeelings;

  @HiveField(2)
  List<Feeling>? secondOrderFeelings;

  @HiveField(3)
  List<Feeling>? thirdOrderFeelings;

  // @HiveField(4)
  // FeelingPropagator? propagator;

  FeelingsList({
    this.id,
    this.firstOrderFeelings,
    this.secondOrderFeelings,
    this.thirdOrderFeelings,
    // this.propagator,
  });

  @override
  void assignAttributes(Map<String, dynamic> map) {}

  void addFeeling(List<Feeling>? firstOrderFeelings) {}

  @override
  Future<void> updateCurrent() async {
    await FeelingsList(
      id: Current.feelings?.id ?? currentID,
      firstOrderFeelings:
          firstOrderFeelings ?? Current.feelings?.firstOrderFeelings ?? [],
      secondOrderFeelings:
          secondOrderFeelings ?? Current.feelings?.secondOrderFeelings ?? [],
      thirdOrderFeelings:
          thirdOrderFeelings ?? Current.feelings?.thirdOrderFeelings ?? [],
      // propagator:
      //     propagator ?? Current.feelings?.propagator ?? FeelingPropagator(),
    ).save();
  }
}
