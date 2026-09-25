import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/regiments/regiment.dart';
import 'package:system_mapper/data/hive_objects/regiments/regiment_archives.dart';
import 'package:system_mapper/data/model_classes/base_model.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/data/model_classes/type_ids.dart';

part 'medication.g.dart';

@HiveType(typeId: TypeIds.medication)
class Medication extends BaseModel {
  @override
  ModelType<Medication> get modelType => ModelType.medication;

  @override
  String? get currentID => null;

  @override
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? medicationName;

  @HiveField(2)
  int? milligrams;

  @HiveField(3)
  DateTime? nextTarget;

  @HiveField(4)
  DateTime? interval;

  @HiveField(5)
  Regiment? parentRegiment;

  Medication({
    this.id,
    this.medicationName,
    this.milligrams,
    this.nextTarget,
    this.interval,
  });

  @override
  void assignAttributes(Map<String, dynamic> map) {}

  @override
  Future<void> updateCurrent() async {
    bool alreadyFound = false;
    List<Medication> medications =
        ModelType.medicationRegimentArchive
            .getCurrent()
            ?.indefiniteRegiment
            ?.medications ??
        [];
    int foundIndex = 0;
    Medication? foundInIndefinite;
    for (Medication medication in medications) {
      if (medication.medicationName == medicationName &&
          medication.milligrams == milligrams) {
        foundInIndefinite = medication;
        alreadyFound = true;
      } else if (!alreadyFound) {
        foundIndex = foundIndex + 1;
      }
    }
    if (foundInIndefinite != null) {
      medications.replaceRange(foundIndex, foundIndex, [this]);
      RegimentArchive(
        indefiniteRegiment: Regiment(
          regimentName: ModelType.medicationRegimentArchive
              .getCurrent()
              ?.indefiniteRegiment
              ?.regimentName,
          medications: medications,
        ),
      ).updateCurrent();
    } else {
      addToCurrent(isIndefinite: true);
    }

    List<Regiment> regiments =
        ModelType.medicationRegimentArchive.getCurrent()?.temporaryRegiments ??
        [];
    Regiment? possibleFoundRegiment;
    int foundRegimentIndex = 0;
    Medication? possibleFoundMedication;
    int foundMedicationIndex = 0;
    for (Regiment regiment in regiments) {
      if (possibleFoundRegiment == null) {
        foundRegimentIndex = foundRegimentIndex + 1;
      } else if (regiment.regimentName == parentRegiment?.regimentName) {
        possibleFoundRegiment = regiment;
      }
      if (possibleFoundRegiment != null && possibleFoundMedication == null) {
        for (Medication medication in possibleFoundRegiment.medications!) {
          if (possibleFoundMedication != null) {
            foundMedicationIndex = foundMedicationIndex + 1;
          } else if (medication.medicationName == medicationName &&
              medication.milligrams == milligrams) {
            possibleFoundMedication = medication;
          }
        }
      }
    }
    if (possibleFoundMedication == null) {
      addToCurrent(isTemporary: true);
    }
  }

  Future<void> addToCurrent({bool? isIndefinite, bool? isTemporary}) async {
    if (isIndefinite ?? false) {
      List<Medication> medications = [
        this,
        ...ModelType.medicationRegimentArchive
                .getCurrent()
                ?.indefiniteRegiment
                ?.medications ??
            [],
      ];
      medications.sort((medOne, medTwo) {
        return medOne.nextTarget!.compareTo(medTwo.nextTarget!);
      });
      RegimentArchive(
        indefiniteRegiment: Regiment(medications: medications),
      ).updateCurrent();
    }
    if (isTemporary ?? false) {
      for (Regiment regiment
          in ModelType.medicationRegimentArchive
                  .getCurrent()
                  ?.temporaryRegiments ??
              []) {
        if (regiment.regimentName == parentRegiment?.regimentName) {
          regiment.medications?.insert(0, this);
          regiment.medications?.sort((medOne, medTwo) {
            return medOne.nextTarget!.compareTo(medTwo.nextTarget!);
          });
          regiment.updateCurrent();
        }
      }
    }
  }
}
