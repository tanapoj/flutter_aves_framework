import 'package:flutter/widgets.dart';

abstract class AvesNavigator {
  syncInit() {}

  asyncInit() async {
    return Future.value(null);
  }

  Widget startup();

  Widget home();
}

class NavigatorResult {
  final int code;
  final Map<String, dynamic> result;

  NavigatorResult({
    this.code = 0,
    this.result = const {},
  });

  put(String key, dynamic value) {
    result[key] = value;
  }

  dynamic get(String key) {
    return result.containsKey(key) ? result[key] : null;
  }

  dynamic operator [](String key) => get(key);
}
