import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/hive_objects/feelings/feelings.dart';
import 'package:system_mapper/data/hive_objects/front/archive_types/single_front/single_front.dart';
import 'package:system_mapper/data/hive_objects/front/archive_types/single_front/single_front_archive.dart';
import 'package:system_mapper/data/hive_objects/front/archive_types/standard/front.dart';
import 'package:system_mapper/data/hive_objects/front/archive_types/standard/front_archive.dart';
import 'package:system_mapper/data/hive_objects/settings/cursor.dart';
import 'package:system_mapper/data/hive_objects/settings/settings.dart';
import 'package:system_mapper/data/hive_objects/system/system.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/data/propagators/feeling_propagator.dart';

class Current {
  // System
  static System? get system => ModelType.system.getCurrent();

  static ValueListenable<Box<System>> get systemListenable =>
      ModelType.system.appBox.valueListenableForId(System().currentID);

  static FeelingsList? get feelings => ModelType.feelings.getCurrent();

  static ValueListenable<Box<FeelingsList>> get feelingsListenable =>
      ModelType.feelings.appBox.valueListenableForId(FeelingsList().currentID);

  // Standard Front
  static StandardFront? get standardFront =>
      ModelType.standardFront.getCurrent();

  static ValueListenable<Box<StandardFront>> get standardFrontListenable =>
      ModelType.standardFront.appBox.valueListenableForId(
        StandardFront().currentID,
      );

  static StandardFrontArchive? get standardFrontArchive =>
      ModelType.standardFrontArchive.getCurrent();

  static ValueListenable<Box<StandardFrontArchive>>
  get standardFrontArchiveListenable => ModelType.standardFrontArchive.appBox
      .valueListenableForId(StandardFrontArchive().currentID);

  // Single Front
  static SingleFront? get singleFront => ModelType.singleFront.getCurrent();

  static ValueListenable<Box<SingleFront>> get singleFrontListenable =>
      ModelType.singleFront.appBox.valueListenableForId(
        SingleFront().currentID,
      );

  static SingleFrontArchive? get singleFrontArchive =>
      ModelType.singleFrontArchive.getCurrent();

  static ValueListenable<Box<SingleFrontArchive>>
  get singleFrontArchiveListenable => ModelType.singleFrontArchive.appBox
      .valueListenableForId(SingleFrontArchive().currentID);

  // Settings
  static Settings? get settings => ModelType.settings.getCurrent();

  static ValueListenable<Box<Settings>> get settingsListenable =>
      ModelType.settings.appBox.valueListenableForId(Settings().currentID);

  static Cursor? get cursor => ModelType.cursor.getCurrent();

  static ValueListenable<Box<Cursor>> get cursorListenable =>
      ModelType.cursor.appBox.valueListenableForId(Cursor().currentID);

  // Propagators
  static FeelingPropagator get feelingsPropagator => FeelingPropagator();
}
