import 'dart:io';

import '../command.dart';
import '../io/file.dart';
import '../io/printer.dart';
import '../io/template.dart';
import 'action.dart';
import 'make_model.dart';
import 'make_page.dart';

class InitAction extends Action {
  @override
  String get name => 'init';

  @override
  bool checkCanExecCmd(Command input) {
    if (input.cmd == 'init') return true;
    return false;
  }

  @override
  bool verifyOptionsAndArguments(Command input) {
    return true;
  }

  @override
  exec(Command input) async {
    var outputDirectory = input.arguments['--dir'] ?? 'lib';
    var overwrite = input.arguments.containsKey('--overwrite');
    var dry = input.arguments.containsKey('--dry');
    var blank = input.arguments.containsKey('--blank');

    var dirs = [
      '$outputDirectory/app',
      '$outputDirectory/common',
      '$outputDirectory/common/extension',
      '$outputDirectory/config',
      '$outputDirectory/data',
      '$outputDirectory/data/db',
      '$outputDirectory/data/network',
      '$outputDirectory/data/preference',
      '$outputDirectory/model',
      '$outputDirectory/model/api',
      '$outputDirectory/model/local',
      '$outputDirectory/ui',
      '$outputDirectory/ui/main',
      '$outputDirectory/ui/pages',
      '$outputDirectory/ui/widgets',
    ];

    try {
      printer.writeln('${printer.blue('[i] generate framework template files at:')} $outputDirectory');

      for (var dir in dirs) {
        var d = Directory(dir);
        if (!await d.exists()) {
          if (!dry) {
            await d.create(recursive: true);
          }
          printer.writeln('${printer.blue('    create directory:')} $dir');
        }
      }

      String prefix = '${printer.blue('    create file:')} ';

      // app
      printer.writeln('$prefix ${await _createFile(
        outputDir: outputDirectory,
        outputFile: 'main.dart',
        template: 'init/main',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/app',
        outputFile: 'app_auth.dart',
        template: 'init/app/app_auth',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/app',
        outputFile: 'app_component.dart',
        template: 'init/app/app_component',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/app',
        outputFile: 'app_navigator.dart',
        template: 'init/app/app_navigator',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/app',
        outputFile: 'app_provider.dart',
        template: 'init/app/app_provider',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/app',
        outputFile: 'app_translator.dart',
        template: 'init/app/app_translator',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/app',
        outputFile: 'environment.dart',
        template: 'init/app/environment',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      // common
      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/common',
        outputFile: 'helpers.dart',
        template: 'init/common/helpers',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/common/extension',
        outputFile: 'string.dart',
        template: 'init/common/extension/string',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      // db
      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/data/db',
        outputFile: 'database.dart',
        template: 'init/data/db/database',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');
      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/data/network',
        outputFile: 'app_api.dart',
        template: 'init/data/network/app_api',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');
      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/data/preference',
        outputFile: 'app_pref.dart',
        template: 'init/data/preference/app_pref',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      // model
      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/model',
        outputFile: 'user.dart',
        template: 'init/model/user',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      // root
      printer.writeln('$prefix ${await _createFile(
        outputDir: '',
        outputFile: 'build.yaml',
        template: 'init/build.yaml',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      printer.writeln('$prefix ${await _createFile(
        outputDir: '.aves',
        outputFile: 'aves_config.json',
        template: '.aves/aves_config.json',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      // HomePage
      var status;
      status = await MakePageAction().exec(Command.copyWith(
        input,
        cmd: 'make:page',
        options: ['home'],
        arguments: {
          '--dir': '$outputDirectory/ui/pages',
        },
      ));
      if (status != 0) return status;

      status = await MakeModelAction().exec(Command.copyWith(
        input,
        cmd: 'make:model',
        options: ['api/item'],
        arguments: {
          '--dir': '$outputDirectory/model',
        },
      ));
      if (status != 0) return status;
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
