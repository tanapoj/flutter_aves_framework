import 'package:aves_support/common/extension/list.dart';
import 'package:aves_support/common/extension/string.dart';
import 'package:recase/recase.dart';

import '../command.dart';
import '../io/file.dart';
import '../io/printer.dart';
import '../io/template.dart';
import 'action.dart';

class MakeModelAction extends Action {
  @override
  String get name => 'make:model';

  @override
  bool checkCanExecCmd(Command input) {
    if (input.cmd == 'make:model') return true;
    return false;
  }

  @override
  bool verifyOptionsAndArguments(Command input) {
    String? modelName = input.options.elementAtOrNull(0);
    if (modelName == null) {
      printer.writeln(printer.red('-h'));
      return false;
    }
    for (var n in modelName.split('/') ?? []) {
      var re = RegExp(r'^[a-zA-Z_]{1}[a-zA-Z0-9_]{1,256}$');
      if (!re.hasMatch(ReCase(n).snakeCase)) {
        printer.writeln(printer.red('"$n" in "$modelName" is not variable name format!'));
        return false;
      }
    }

    return true;
  }

  @override
  exec(Command input) async {
    var outputDirectory = input.arguments['--dir'] ?? 'lib/model';
    var noPrefixModel = input.arguments.containsKey('--no-prefix');
    var overwrite = input.arguments.containsKey('--overwrite');
    var dry = input.arguments.containsKey('--dry');

    if (!outputDirectory.endsWith('/')) {
      outputDirectory += '/';
    }

    List<String> paths = input.options.elementAt(0).split('/');
    String name = paths.last;
    paths.removeLast();

    ReCase rc = ReCase(name);
    var nameSnakeCase = rc.snakeCase;
    var nameCamelCase = rc.camelCase.toCapitalize();

    var finalNameCamelCase = noPrefixModel ? nameCamelCase : '${nameCamelCase}Model';

    var outputPath = paths.join('/');
    var outputFile = '$outputDirectory${outputPath.isEmpty ? '' : '$outputPath/'}$nameSnakeCase.dart';
    printer.writeln('${printer.blue('[i] generate template for class:')} $finalNameCamelCase');
    printer.writeln('${printer.blue('    create file:')} $outputFile');

    var content = await makeTemplate('model', {
      'fileName': outputFile,
      'className': finalNameCamelCase,
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
