import 'dart:io';

import 'package:aves_support/common/extension/list.dart';
import 'package:aves_support/common/extension/string.dart';
import 'package:recase/recase.dart';

import '../command.dart';
import '../io/printer.dart';
import '../io/template.dart';
import 'action.dart';
import 'make_logic.dart';
import 'make_view.dart';

class MakePageAction extends Action {
  @override
  String get name => 'make:page';

  @override
  bool checkCanExecCmd(Command input) {
    if (input.cmd == 'make:page') return true;
    return false;
  }

  @override
  bool verifyOptionsAndArguments(Command input) {
    String? pageName = input.options.elementAtOrNull(0);
    if (pageName == null) {
      printer.writeln(printer.red('-h'));
      return false;
    }
    for (var n in pageName.split('/') ?? []) {
      var re = RegExp(r'^[a-zA-Z_]{1}[a-zA-Z0-9_]{1,256}$');
      if (!re.hasMatch(ReCase(n).snakeCase)) {
        printer.writeln(printer.red('"$n" in "$pageName" is not variable name format!'));
        return false;
      }
    }

    return true;
  }

  @override
  exec(Command input) async {
    var outputDirectory = input.arguments['--dir'] ?? 'lib/ui/pages';
    var dry = input.arguments.containsKey('--dry');

    if (!outputDirectory.endsWith('/')) {
      outputDirectory += '/';
    }

    String name = input.options[0];

    List<String> names = name.split('/').map((n) {
      return ReCase(n).snakeCase;
    }).toList();

    // ReCase rc = ReCase(name);
    // var nameSnakeCase = rc.snakeCase;
    var nameSnakeCase = names.join('/');

    if (!await Directory('$outputDirectory$nameSnakeCase').exists()) {
      if (!dry) {
        await Directory('$outputDirectory$nameSnakeCase').create(recursive: true);
      }
    }

    input.options[0] = '$nameSnakeCase/${names.last}';

    // Logic
    var status = await MakeLogicAction().exec(input);
    if (status != 0) return status;
    // View
    status = await MakeViewAction().exec(input);
    return status;
  }
}
