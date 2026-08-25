import 'package:flutter/foundation.dart';
import 'package:system_mapper/data/hive_objects/front.dart';
import 'package:system_mapper/data/hive_objects/system.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';

class Current {
  // System
  static System? get system => ModelType.system.getCurrent();

  static Front? get front => ModelType.front.getCurrent();

  static ValueListenable get systemListenable =>
      ModelType.system.appBox.valueListenableForId(System().currentID);
}
