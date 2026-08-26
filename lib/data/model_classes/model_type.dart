import 'package:system_mapper/data/hive_objects/front.dart';
import 'package:system_mapper/data/hive_objects/member.dart';
import 'package:system_mapper/data/hive_objects/system.dart';
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
    final BaseModel model;

    switch (this) {
      // case ModelType.genericType:
      //   model = GenericClass();
      //   break;
      case ModelType.system:
        model = System();
        break;
      case ModelType.member:
        model = Member();
        break;
      case ModelType.front:
        model = Front();
        break;
    }

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
    final BaseModel model;

    switch (this) {
      // case ModelType.genericType:
      //   model = GenericClass();
      //   break;
      case ModelType.system:
        model = System();
        break;
      case ModelType.member:
        model = Member();
        break;
      case ModelType.front:
        model = Front();
        break;
    }

    return appBox.getById(model.currentID);
  }
}
