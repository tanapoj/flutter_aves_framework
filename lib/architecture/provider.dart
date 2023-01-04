import 'package:aves/architecture/environment.dart';
import 'package:flutter/material.dart' as m;

// ignore: must_be_immutable
abstract class AvesProvider extends m.InheritedWidget {
  Environment env;

  AvesProvider({
    m.Key? key,
    required m.Widget child,
    required this.env,
  }) : super(key: key, child: child);

  static AvesProvider of(m.BuildContext context) {
    final AvesProvider? result = context.dependOnInheritedWidgetOfExactType<AvesProvider>();
    assert(result != null, 'No AvesProvider found in context');
    return result!;
  }

  /// init when create app
  syncInit();

  /// init after create app, but before load first page
  asyncInit() async {}
}
