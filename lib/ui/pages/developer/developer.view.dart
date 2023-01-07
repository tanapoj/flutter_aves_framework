/// Project: aves
/// Author: ta
/// Created at: 2023-01-04

import 'package:aves/architecture/component/view.dart';
import 'package:flutter/material.dart';
import 'developer.logic.dart';

class DeveloperView extends View<DeveloperLogic> {
  const DeveloperView(
    DeveloperLogic logic, {
    Key? key,
  }) : super(logic, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Developer Console'),
      ),
      body: const Center(
        child: Text('placeholder for Developer'),
      ),
    );
  }
}
