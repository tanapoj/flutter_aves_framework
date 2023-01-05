import 'dart:io';

import 'package:aves_support/common/extension/list.dart';
import 'package:aves_support/common/extension/string.dart';
import 'package:recase/recase.dart';

import '../command.dart';
import '../io/file.dart';
import '../io/printer.dart';
import '../io/template.dart';
import 'action.dart';
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
          d.create(recursive: true);
          printer.writeln('${printer.blue('    create directory:')} $dir');
        }
      }

      String prefix = '${printer.blue('    create file:')} ';

      // app
      printer.writeln('$prefix ${await _createFile(
        outputDirectory,
        'main.dart',
        'init/main',
        {
          '': '',
        },
        overwrite,
      )}');

      printer.writeln('$prefix ${await _createFile(
        '$outputDirectory/app',
        'app_auth.dart',
        'init/app/app_auth',
        {
          '': '',
        },
        overwrite,
      )}');

      printer.writeln('$prefix ${await _createFile(
        '$outputDirectory/app',
        'app_component.dart',
        'init/app/app_component',
        {
          '': '',
        },
        overwrite,
      )}');

      printer.writeln('$prefix ${await _createFile(
        '$outputDirectory/app',
        'app_navigator.dart',
        'init/app/app_navigator',
        {
          '': '',
        },
        overwrite,
      )}');

      printer.writeln('$prefix ${await _createFile(
        '$outputDirectory/app',
        'app_provider.dart',
        'init/app/app_provider',
        {
          '': '',
        },
        overwrite,
      )}');

      printer.writeln('$prefix ${await _createFile(
        '$outputDirectory/app',
        'app_translator.dart',
        'init/app/app_translator',
        {
          '': '',
        },
        overwrite,
      )}');

      printer.writeln('$prefix ${await _createFile(
        '$outputDirectory/app',
        'environment.dart',
        'init/app/environment',
        {
          '': '',
        },
        overwrite,
      )}');

      // common
      printer.writeln('$prefix ${await _createFile(
        '$outputDirectory/common',
        'helpers.dart',
        'init/common/helpers',
        {
          '': '',
        },
        overwrite,
      )}');

      printer.writeln('$prefix ${await _createFile(
        '$outputDirectory/common/extension',
        'string.dart',
        'init/common/extension/string',
        {
          '': '',
        },
        overwrite,
      )}');

      // common
      printer.writeln('$prefix ${await _createFile(
        '$outputDirectory/model',
        'user.dart',
        'init/model/user',
        {
          '': '',
        },
        overwrite,
      )}');

      // root
      printer.writeln('$prefix ${await _createFile(
        '',
        'build.yaml',
        'init/build.yaml',
        {
          '': '',
        },
        overwrite,
      )}');

      // HomePage
      var status = await MakePageAction().exec(Command(
        cmd: 'make:page',
        options: ['home'],
        arguments: {'--dir': '$outputDirectory/ui/pages'},
      ));
      if (status != 0) return status;
    } catch (e) {
      printer.writeln(printer.red('[e] $e'));
      return 2;
    }

    return 0;
  }

  Future<String?> _createFile(
    String dir,
    String outputFile,
    String template,
    Map<String, dynamic> vars,
    bool overwrite,
  ) async {
    var content = await makeTemplate(template, vars);

    try {
      var path = dir.isEmpty ? outputFile : '$dir/$outputFile';
      if (!overwrite && await File(path).exists()) {
        throw ConflictingOutputsException(
          'File "$path" already exist. if you want to override file, use flag --overwrite',
        );
      }
      var d = Directory(dir);
      if (dir.isNotEmpty && !await d.exists()) {
        await d.create(recursive: true);
      }
      await writeFile(path, content);
      return path;
    } catch (e) {
      if (e is ConflictingOutputsException) rethrow;
      printer.writeln(printer.red(e.toString()));
      return null;
    }
  }
}

class ConflictingOutputsException extends Error {
  final String message;

  ConflictingOutputsException(this.message);

  @override
  String toString() {
    return message;
  }
}
