import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/model_classes/base_model.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/data/model_classes/type_ids.dart';

part 'cursor.g.dart';

@HiveType(typeId: TypeIds.cursor)
class Cursor extends BaseModel {
  @override
  ModelType<Cursor> get modelType => ModelType.cursor;

  // TODO: Anonymise with a generated UUID
  @override
  String get currentID => 'current-cursor-id';

  @override
  @HiveField(0)
  String? id;

  @HiveField(1)
  double? cursorX;

  @HiveField(2)
  double? cursorY;

  @HiveField(3)
  int? refreshRate;

  @HiveField(4)
  int? windowWidth;

  @HiveField(5)
  int? windowHeight;

  Cursor({
    this.id,
    this.cursorX,
    this.cursorY,
    this.refreshRate,
    this.windowWidth,
    this.windowHeight,
  });

  @override
  void assignAttributes(Map<String, dynamic> map) {}

  @override
  Future<void> updateCurrent() async {
    await Cursor(
      id: currentID,
      cursorX: cursorX ?? modelType.appBox.getById(id)?.cursorX,
      cursorY: cursorY ?? modelType.appBox.getById(id)?.cursorY,
      refreshRate: refreshRate ?? modelType.appBox.getById(id)?.refreshRate,
      windowWidth: windowWidth ?? modelType.appBox.getById(id)?.windowWidth,
      windowHeight: windowHeight ?? modelType.appBox.getById(id)?.windowHeight,
    ).saveSafely();
  }

  Future<void> saveSafely() async {
    await Cursor(
      id: id,
      cursorX: cursorX ?? modelType.appBox.getById(id)?.cursorX,
      cursorY: cursorY ?? modelType.appBox.getById(id)?.cursorY,
      refreshRate: refreshRate ?? modelType.appBox.getById(id)?.refreshRate,
      windowWidth: windowWidth ?? modelType.appBox.getById(id)?.windowWidth,
      windowHeight: windowHeight ?? modelType.appBox.getById(id)?.windowHeight,
    ).save();
  }

  void updateMouseLocation(PointerEvent details) {
    // debugPrint(details.position.dx.toString());
    // debugPrint(details.position.dy.toString());
    cursorX = details.position.dx;
    cursorY = details.position.dy;
    saveSafely();
  }

  void updateCurrentMouseLocation(PointerEvent details) {
    // debugPrint(details.position.dx.toString());
    // debugPrint(details.position.dy.toString());
    cursorX = details.position.dx;
    cursorY = details.position.dy;

    // debugPrint(cursorY.toString());
    // debugPrint(cursorX.toString());
    updateCurrent();
  }
}
