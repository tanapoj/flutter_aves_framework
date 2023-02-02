import 'dart:io';

import 'package:aves/common/extension/list.dart';
import 'package:aves/common/extension/string.dart';
import 'package:recase/recase.dart';

import '../command.dart';
import '../io/file.dart';
import '../io/printer.dart';
import '../io/template.dart';
import 'action.dart';

class MakeViewAction extends Action {
  @override
  String get name => 'make:view';

  @override
  bool checkCanExecCmd(Command input) {
    if (input.cmd == 'make:view') return true;
    return false;
  }

  @override
  bool verifyOptionsAndArguments(Command input) {
    String? viewName = input.options.elementAtOrNull(0);
    if (viewName == null) {
      printer.writeln(printer.red('-h'));
      return false;
    }
    for (var n in viewName.split('/') ?? []) {
      var re = RegExp(r'^[a-zA-Z_]{1}[a-zA-Z0-9_]{1,256}$');
      if (!re.hasMatch(ReCase(n).snakeCase)) {
        printer.writeln(printer.red('"$n" in "$viewName" is not variable name format!'));
        return false;
      }
    }

    return true;
  }

  @override
  exec(Command input) async {
    var outputDirectory = input.arguments['--dir'] ?? 'lib/ui/pages';
    var overwrite = input.arguments.containsKey('--overwrite');
    var dry = input.arguments.containsKey('--dry');
    var useBlankTemplate = input.arguments.containsKey('--blank');

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
    var outputFile = '$outputDirectory${outputPath.isEmpty ? '' : '$outputPath/'}$nameSnakeCase.view.dart';
    printer.writeln('${printer.blue('[i] generate template for class:')} ${nameCamelCase}View');
    printer.writeln('${printer.blue('    create file:')} $outputFile');

    var templateName = useBlankTemplate ? 'view-blank' : 'view';
    var content = await makeTemplate(templateName, {
      'fileName': outputFile,
      'className': nameCamelCase,
      'class_name': nameSnakeCase,
    });

    try {
      await writeFile(outputFile, content, overwrite: overwrite, runDry: dry);
      return 0;
    } catch (e) {
      printer.writeln(printer.red(e.toString()));
      return 1;
    }
  }
}
