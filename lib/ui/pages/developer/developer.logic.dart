/// Project: aves
/// Author: ta
/// Created at: 2023-01-04

import 'package:flutter/material.dart';
import 'package:flutter_live_data/index.dart';
import 'package:aves/component/logic.dart';
import 'developer.view.dart';

class DeveloperLogic extends Logic {
  @override
  String get name => 'developer';

  final LifeCycleOwner? parent;

  DeveloperLogic({
    Key? key,
    required Widget Function(dynamic) builder,
    this.parent,
  }) : super(key: key, builder: builder);

  factory DeveloperLogic.build({LifeCycleOwner? parent}) {
    return DeveloperLogic(
      parent: parent,
      builder: (logic) => DeveloperView(logic as DeveloperLogic),
    );
  }
}
