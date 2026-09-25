import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/regiments/medication.dart';
import 'package:system_mapper/data/hive_objects/regiments/regiment_archives.dart';
import 'package:system_mapper/data/model_classes/base_model.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/data/model_classes/type_ids.dart';

part 'regiment.g.dart';

@HiveType(typeId: TypeIds.regiment)
class Regiment extends BaseModel {
  @override
  ModelType<Regiment> get modelType => ModelType.regiment;

  @override
  String get currentID => '9c4d11ae-fd39-44ae-935c-145cb4a3d2d3';

  @override
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? regimentName;

  @HiveField(2)
  List<Medication>? medications;

  @HiveField(3)
  DateTime? endOfRegiment;

  Regiment({this.id, this.regimentName, this.medications, this.endOfRegiment});

  @override
  void assignAttributes(Map<String, dynamic> map) {}

  @override
  Future<void> updateCurrent() async {
    await RegimentArchive(
      indefiniteRegiment: isTemporary
          ? ModelType.medicationRegimentArchive.getCurrent()?.indefiniteRegiment
          : this,
    ).updateCurrent();
    if (isTemporary) {
      Regiment? possibleRegiment;
      int regimentIndex = 0;
      bool alreadyFound = false;
      for (Regiment regiment
          in ModelType.medicationRegimentArchive
                  .getCurrent()
                  ?.temporaryRegiments ??
              []) {
        if (regiment.regimentName == regimentName) {
          possibleRegiment = regiment;
          alreadyFound;
        } else if (!alreadyFound) {
          regimentIndex = regimentIndex + 1;
        }
      }
      if (possibleRegiment != null) {
        List<Regiment> regiments = [
          ...RegimentArchive().modelType.getCurrent()?.temporaryRegiments ?? [],
        ];
        regiments.replaceRange(regimentIndex, regimentIndex, [
          Regiment(
            medications: medications ?? possibleRegiment.medications,
            endOfRegiment: endOfRegiment ?? possibleRegiment.endOfRegiment,
          ),
        ]);
        await RegimentArchive(temporaryRegiments: regiments).updateCurrent();
      } else {
        addToCurrent();
      }
    }
  }

  Future<void> addToCurrent() async {
    if (isTemporary) {
      List<Regiment> regiments = [
        this,
        ...RegimentArchive().modelType.getCurrent()?.temporaryRegiments ?? [],
      ];
      await RegimentArchive(temporaryRegiments: regiments).updateCurrent();
    }
  }

  bool get isTemporary => endOfRegiment != null;
}
