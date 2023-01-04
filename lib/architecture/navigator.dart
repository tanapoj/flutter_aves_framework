import 'package:flutter/widgets.dart';

abstract class AvesNavigator {
  syncInit() {}

  asyncInit() async {
    return Future.value(null);
  }

  // Widget startup();
  //
  // Widget home();
}
