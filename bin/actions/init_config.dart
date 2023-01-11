import 'dart:io';

import '../command.dart';
import '../io/file.dart';
import '../io/printer.dart';
import '../io/template.dart';
import 'action.dart';
import 'make_model.dart';
import 'make_page.dart';

class InitConfigAction extends Action {
  @override
  String get name => 'init:config';

  @override
  bool checkCanExecCmd(Command input) {
    if (input.cmd == 'init:config') return true;
    return false;
  }

  @override
  bool verifyOptionsAndArguments(Command input) {
    return true;
  }

  @override
  exec(Command input) async {
    var overwrite = input.arguments.containsKey('--overwrite');
    var dry = input.arguments.containsKey('--dry');
    var useFvm = input.arguments.containsKey('--use-fvm');

    try {
      printer.writeln(printer.blue('[i] generate config file'));
      String prefix = '${printer.blue('    create file:')} ';

      printer.writeln('$prefix ${await _createFile(
        outputDir: '.aves',
        outputFile: 'aves_config.yaml',
        template: 'init/.aves/aves_config.yaml',
        vars: {
          'command': useFvm ? 'fvm' : 'flutter',
        },
        overwrite: overwrite,
        dry: dry,
      )}');
    } catch (e) {
      printer.writeln(printer.red('[e] $e'));
      return 2;
    }

    return 0;
  }

  Future<String?> _createFile({
    required String outputDir,
    required String outputFile,
    required String template,
    required Map<String, dynamic> vars,
    required bool overwrite,
    required bool dry,
  }) async {
    var content = await makeTemplate(template, vars);

    try {
      var path = outputDir.isEmpty ? outputFile : '$outputDir/$outputFile';
      if (!overwrite && await File(path).exists()) {
        throw ConflictingOutputsException(
          'File "$path" already exist. if you want to override file, use flag --overwrite',
        );
      }
      var d = Directory(outputDir);
      if (outputDir.isNotEmpty && !await d.exists()) {
        if (!dry) {
          await d.create(recursive: true);
        }
      }
      await writeFile(path, content, overwrite: overwrite, runDry: dry);
      return path;
    } catch (e) {
      if (e is ConflictingOutputsException) rethrow;
      printer.writeln(printer.red(e.toString()));
      return null;
    }
  }
}
