import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:system_mapper/data/model_classes/base_model.dart';
import 'package:system_mapper/data/model_classes/model_type.dart';
import 'package:system_mapper/data/model_classes/type_ids.dart';
import 'package:system_mapper/utils/current.dart';

part 'settings.g.dart';

@HiveType(typeId: TypeIds.settings)
class Settings extends BaseModel {
  @override
  ModelType<Settings> get modelType => ModelType.settings;

  // TODO: Anonymise with a generated UUID
  @override
  String get currentID => 'current-settings-id';

  @override
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? themeMode;

  Settings({this.id, this.themeMode});

  @override
  void assignAttributes(Map<String, dynamic> map) {}

  @override
  Future<void> updateCurrent() async {
    await Settings(
      id: currentID,
      themeMode: themeMode ?? Current.settings?.themeMode,
    ).saveSafely();
  }

  Future<void> saveSafely() async {
    await Settings(
      id: id,
      themeMode: themeMode ?? modelType.appBox.getById(id)?.themeMode,
    ).save();
  }

  void toggleThemeMode() async {
    if (themeMode == null) {
      debugPrint('ThemeMode not set...');
      setThemeMode();
    } else {
      if (ThemeMode.system.parse(themeMode!).isDark) {
        themeMode = ThemeMode.light.name;
        updateCurrent();
      } else {
        themeMode = ThemeMode.dark.name;
        updateCurrent();
      }
    }
  }

  void setThemeMode() async {
    if (themeMode == null) {
      debugPrint('ThemeMode not set...');
      themeMode = ThemeMode.light.name;
      updateCurrent();
    }
  }
}

extension ThemeModeMethods on ThemeMode {
  ThemeMode? tryParse(String? str) {
    switch (str) {
      case ('system'):
        return ThemeMode.system;
      case ('light'):
        return ThemeMode.light;
      case ('dark'):
        return ThemeMode.dark;
      default:
        return null;
    }
  }

  ThemeMode parse(String? str) {
    switch (str) {
      case ('system'):
        return ThemeMode.system;
      case ('light'):
        return ThemeMode.light;
      case ('dark'):
        return ThemeMode.dark;
      default:
        throw ArgumentError(
          'The string value must be any of the following: \n     \'system\', \'light\', or \'dark\' ',
          'ThemeMode.parse() String argument error',
        );
    }
  }
}
