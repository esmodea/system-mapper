import 'package:system_mapper/data/hive_objects/front/front.dart';
import 'package:system_mapper/data/hive_objects/front/front_archive.dart';
import 'package:system_mapper/data/hive_objects/front/front_entry.dart';
import 'package:system_mapper/data/hive_objects/settings/settings.dart';
import 'package:system_mapper/data/hive_objects/system/member.dart';
import 'package:system_mapper/data/hive_objects/system/system.dart';
import 'package:system_mapper/data/model_classes/type_ids.dart';

import 'app_box.dart';
import 'base_model.dart';

enum ModelType<T extends BaseModel> {
  // genericType(
  //     name: 'genericName',
  //     pluralName: 'genericNames',
  //     title: 'Generic Name',
  //     pluralTitle: 'Generic Names',
  //     appBox: AppBox<GenericClass>(
  //       key: 'stUser',
  //       typeId: TypeIds.genericId,
  //     )),
  system(
    name: 'system',
    pluralName: 'systems',
    title: 'System',
    pluralTitle: 'Systems',
    appBox: AppBox<System>(key: 'system', typeId: TypeIds.system),
  ),
  member(
    name: 'member',
    pluralName: 'members',
    title: 'Member',
    pluralTitle: 'Members',
    appBox: AppBox<Member>(key: 'member', typeId: TypeIds.member),
  ),
  front(
    name: 'front',
    pluralName: 'front',
    title: 'Front',
    pluralTitle: 'Front',
    appBox: AppBox<Front>(key: 'front', typeId: TypeIds.front),
  ),
  frontEntry(
    name: 'frontEntry',
    pluralName: 'frontEntries',
    title: 'Front Entry',
    pluralTitle: 'Front Entries',
    appBox: AppBox<FrontEntry>(key: 'frontEntry', typeId: TypeIds.frontEntry),
  ),
  frontArchive(
    name: 'frontArchive',
    pluralName: 'frontArchives',
    title: 'Front Archive',
    pluralTitle: 'Front Archives',
    appBox: AppBox<FrontArchive>(
      key: 'frontArchive',
      typeId: TypeIds.frontArchive,
    ),
  ),
  settings(
    name: 'settings',
    pluralName: 'settings',
    title: 'Settings',
    pluralTitle: 'Settings',
    appBox: AppBox<Settings>(key: 'settings', typeId: TypeIds.settings),
  );

  final String name;
  final String pluralName;
  final String title;
  final String pluralTitle;
  final AppBox<T> appBox;

  const ModelType({
    required this.name,
    required this.pluralName,
    required this.title,
    required this.pluralTitle,
    required this.appBox,
  });

  // static List<X> fromList<X extends BaseModel>(
  //     List<dynamic>? list, ModelType<X> modelType) {
  //   return list
  //           ?.map((e) => modelType.fromMap(e))
  //           .toList()
  //           .whereNotNull()
  //           .toList() ??
  //       [];
  // }

  List<T> fromList(List<dynamic>? list) {
    return list?.map((e) => fromMap(e)).toList().nonNulls.toList() ?? [];
  }

  T? fromMap(dynamic map) {
    if (map == null) return null;
    final BaseModel model = getModel();

    model.assignAttributes(map);

    final T? storedModel = appBox.box.get(model.storageKey);
    if (storedModel != null) {
      storedModel.assignAttributes(map);
      storedModel.save();
      return storedModel;
    } else {
      model.save();
      return model as T;
    }
  }

  T? getCurrent() {
    return appBox.getById(getModel().currentID);
  }

  BaseModel getModel() {
    switch (this) {
      // case ModelType.genericType:
      //   return GenericClass();
      case ModelType.system:
        return System();
      case ModelType.member:
        return Member();
      case ModelType.front:
        return Front();
      case ModelType.frontEntry:
        return FrontEntry();
      case ModelType.frontArchive:
        return FrontArchive();
      case ModelType.settings:
        return Settings();
    }
  }
}
