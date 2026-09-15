import 'package:system_mapper/data/model_classes/base_model.dart';

abstract class Propagator<T extends BaseModel> {
  void propagate() {}

  T? get current;
  bool get hasPropagated;
}
