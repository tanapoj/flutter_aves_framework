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
  late final Map<String, dynamic> data;

  NavigatorResult({
    this.code = 0,
    Map<String, dynamic>? data,
  }) {
    this.data = data ?? {};
  }

  put(String key, dynamic value) {
    data[key] = value;
  }

  dynamic get(String key) {
    return data.containsKey(key) ? data[key] : null;
  }

  dynamic operator [](String key) => get(key);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NavigatorResult && runtimeType == other.runtimeType && code == other.code && data == other.data;

  @override
  int get hashCode => code.hashCode ^ data.hashCode;

  @override
  String toString() {
    return 'NavigatorResult{code: $code, data: $data}';
  }
}
