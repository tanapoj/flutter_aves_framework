import 'package:flutter/foundation.dart';
import 'legacy/index.dart' as legacy;

abstract class View<Logic extends legacy.ComponentLogic> extends legacy.ComponentView<Logic> {
  const View(
    Logic logic, {
    Key? key,
  }) : super(logic, key: key);
}
