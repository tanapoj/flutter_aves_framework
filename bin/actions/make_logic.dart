import 'dart:io';

import 'package:aves_support/common/extension/list.dart';
import 'package:aves_support/common/extension/string.dart';
import 'package:recase/recase.dart';

import '../command.dart';
import '../io/printer.dart';
import '../io/template.dart';
import 'action.dart';

class MakeLogicAction extends Action {
  @override
  String get name => 'make:logic';

  @override
  bool checkCanExecCmd(Command input) {
    if (input.cmd == 'make') return true;
    if (input.cmd == 'make:logic') return true;
    return false;
  }

  @override
  bool verifyOptionsAndArguments(Command input) {
    String? logicName = input.options.elementAtOrNull(0);
    var re = RegExp(r'^[a-zA-Z0-9_]{1,256}$');
    if (logicName == null) {
      printer.writeln(printer.red('-h'));
      return false;
    }
    if (!re.hasMatch(logicName)) {
      printer.writeln(printer.red('"$logicName" is not variable name format!'));
      return false;
    }

    return true;
  }

  @override
  exec(Command input) async {
    var outputDirectory = input.arguments['--dir'] ?? 'lib/ui/pages';
    if (!outputDirectory.endsWith('/')) {
      outputDirectory += '/';
    }

    List<String> paths = input.options.elementAt(0).split('/');
    String name = paths.last;
    paths.removeLast();

    ReCase rc = ReCase(name);
    var nameSnakeCase = rc.snakeCase;
    var nameCamelCase = rc.camelCase.toCapitalize();

    var outputPath = paths.join('/');
    var outputFile = '$outputDirectory${outputPath.isEmpty ? '' : '$outputPath/'}$nameSnakeCase.logic.dart';
    printer.writeln('${printer.blue('[i] generate template for class:')} ${nameCamelCase}Logic');
    printer.writeln('${printer.blue('    create file:')} $outputFile');

    var content = await makeTemplate('logic', {
      'fileName': outputFile,
      'className': nameCamelCase,
      'class_name': nameSnakeCase,
    });

    if (content != null) {
      try {
        await writeFile(outputFile, content);
        return 0;
      } catch (e) {
        printer.writeln(printer.red(e.toString()));
        return 1;
      }
    }
    return 1;
  }
}
