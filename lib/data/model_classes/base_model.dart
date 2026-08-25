import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'package:system_mapper/utils/null_value_listenable.dart';
import 'app_box.dart';
import 'model_type.dart';

abstract class BaseModel extends HiveObject {
  ModelType get modelType;
  AppBox? get appBox => modelType.appBox;

  String? get currentID;

  String get storageKey => isInBox ? key : "${appBox?.key}:$id";
  String? get id => null;
  set id(String? val) {}

  String? get name => id.toString();

  bool get isNew => id == null;
  bool get isNotNew => !isNew;

  Map<String, dynamic> toMap() => {};

  String toJson() {
    return jsonEncode(toMap());
  }

  Listenable? get valueListenable => id == null || appBox == null
      ? const NullValueListenable()
      : appBox?.box.listenable(keys: [storageKey]);
  dynamic get listenable => valueListenable;

  @override
  BoxBase? get box => appBox?.box;

  @override
  String get key => super.key ?? storageKey;

  @override
  Future<void> delete() async {
    if (isInBox) {
      return super.delete();
    }
  }

  @override
  Future<void> save() async {
    if (isInBox) {
      return super.save();
    } else {
      final finalAppBox = appBox;
      if (finalAppBox == null) return;
      return finalAppBox.put(storageKey, this);
    }
  }

  void assignAttributes(Map<String, dynamic> map);

  Future<void> updateCurrent() async {}
}
