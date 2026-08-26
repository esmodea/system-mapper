import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive.dart';
import 'model_type.dart';

import 'app_box.dart';
import 'base_model.dart';

enum ListUpdateType { replace, prepend, append, none }

class AppList<T extends BaseModel> {
  AppBox<List<String>> get listsBox => AppBox.lists;

  final String key;
  final ModelType modelType;

  const AppList({required this.key, required this.modelType});

  List<T> get list =>
      listsBox.box
          .get(key, defaultValue: [])
          ?.map((id) => modelType.appBox.getById(id))
          .nonNulls
          .cast<T>()
          .toList() ??
      [];

  Future<void> update(List<T> value) =>
      listsBox.put(key, value.map((e) => e.id).nonNulls.toList());

  Future<void> addAll(List<T> additional) {
    final finalList = list;
    finalList.addAll(additional);
    return update(finalList);
  }

  Future<void> add(T additional) {
    final finalList = list;
    finalList.add(additional);
    return update(finalList);
  }

  Future<void> prependAll(List<T> additional) {
    final finalList = list;
    finalList.insertAll(0, additional);
    return update(finalList);
  }

  Future<void> clear() {
    return listsBox.box.delete(key);
  }

  Future<void> removeWhere(bool Function(T item) whereClause) {
    final finalList = list.where((element) => !whereClause(element)).toList();
    return update(finalList);
  }

  Future<void> notify() => update(list.cast<T>());

  bool get isEmpty => list.isEmpty;

  ValueListenable<Box<List>> get valueListenable =>
      listsBox.valueListenable(keys: [key]);
  Stream<BoxEvent> watch() => listsBox.box.watch(key: key);

  // Main/shared app lists

  // static AppList<GenericClass> genericMethodName({
  //   type? property,
  // }) =>
  //     AppList<GenericClass>(
  //       key: 'key?property=$property',
  //       modelType: ModelType.genericType,
  //     );

  // static AppList<GenericClass> genericMethodName() =>
  //     AppList<GenericClass>(
  //         key: 'genericKey', modelType: ModelType.genericType);
}
