import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'model_type.dart';

class AppBox<T> {
  final String key;
  final int? typeId;

  const AppBox({
    required this.key,
    required this.typeId,
  });

  Box<T> get box => Hive.box<T>(key);
  LazyBox<T> get lazyBox => Hive.lazyBox<T>(key);

  bool get isOpen => Hive.isBoxOpen(key);

  Future<AppBox<T>> openBox() async {
    try {
      await Hive.openBox<T>(
        key,
        crashRecovery: true,
        compactionStrategy: (entries, deletedEntries) =>
            deletedEntries > 10 && deletedEntries / entries > .15,
      );
    } catch (e) {
      debugPrint(key);
      debugPrint(e.toString());
    }

    return this;
  }

  Future<LazyBox<T>> openLazyBox() {
    return Hive.openLazyBox<T>(key);
  }

  Future<void> put(dynamic key, T value) async {
    return await box.put(key, value);
  }

  T? get(dynamic key) {
    return box.get(key);
  }

  T? getById(dynamic id) => id == null ? null : get(storageKeyForId(id));
  Future<void>? deleteById(dynamic id) => id == null ? null : box.delete(storageKeyForId(id));
  Future<void> delete(dynamic key) => box.delete(key);

  String? storageKeyForId(dynamic id) => id == null ? null : "$key:$id";

  ValueListenable<Box<T>> valueListenable({required List<dynamic> keys}) {
    return box.listenable(keys: keys);
  }

  Future<int> clear() async {
    if (!isOpen) await openBox();
    return box.clear();
  }

  ValueListenable valueListenableForId(dynamic id) =>
      valueListenable(keys: [storageKeyForId(id)]);

  static Future<void> clearAllBoxes() async {
    return Future.forEach(allBoxes, (AppBox appBox) async {
      // print(appBox.name); uncomment if failing because box isn't already open to see which box it was
      await appBox.clear();
    });
  }

  static Future<void> openAllBoxes() async {
    await Future.wait(allBoxes.map((appBox) {
      return appBox.openBox();
    }));
  }

  static void registerAllAdapters() {
    // Hive.registerAdapter<User>(UserAdapter());
  }

  static const AppBox<List<String>> lists = AppBox(key: "lists", typeId: null);

  static Set<AppBox> get allBoxes => ModelType.values
      .map((modelType) => modelType.appBox)
      .nonNulls
      .cast<AppBox>()
      .toSet()
    ..addAll(
      {
        lists,
      },
    );
}
