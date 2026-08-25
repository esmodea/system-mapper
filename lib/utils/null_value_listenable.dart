import 'package:flutter/foundation.dart';

class NullValueListenable extends ValueListenable<dynamic> {
  const NullValueListenable();

  @override
  void addListener(VoidCallback listener) {}

  @override
  void removeListener(VoidCallback listener) {}

  @override
  get value => null;
}
