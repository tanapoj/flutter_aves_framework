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
      'assets',
      '$outputDirectory/app',
      '$outputDirectory/common',
      '$outputDirectory/common/extension',
      '$outputDirectory/config',
      '$outputDirectory/config/env',
      '$outputDirectory/config/lang',
      '$outputDirectory/config/theme',
      '$outputDirectory/data',
      '$outputDirectory/data/db',
      '$outputDirectory/data/network',
      '$outputDirectory/data/preference',
      '$outputDirectory/data/service',
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
        outputFile: 'app_ui.dart',
        template: 'init/app/app_ui',
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

      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/app',
        outputFile: 'global_var.dart',
        template: 'init/app/global_var',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/app',
        outputFile: 'index.dart',
        template: 'init/app/index',
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
        outputDir: '$outputDirectory/common',
        outputFile: 'live_data.dart',
        template: 'init/common/live_data',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/common',
        outputFile: 'translate.dart',
        template: 'init/common/translate',
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

      // config
      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/config/env',
        outputFile: 'dev_api.dart',
        template: 'init/config/env/dev_api',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/config/env',
        outputFile: 'dev_mock.dart',
        template: 'init/config/env/dev_mock',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/config/env',
        outputFile: 'prod_api.dart',
        template: 'init/config/env/prod_api',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      for(var theme in ['theme1', 'theme2']) {
        printer.writeln('$prefix ${await _createFile(
          outputDir: '$outputDirectory/config/theme',
          outputFile: '$theme.dart',
          template: 'init/config/theme/$theme',
          vars: {
            '': '',
          },
          overwrite: overwrite,
          dry: dry,
        )}');
      }

      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/config',
        outputFile: 'assets.dart',
        template: 'init/config/assets',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/config',
        outputFile: 'di.dart',
        template: 'init/config/di',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/config',
        outputFile: 'log.dart',
        template: 'init/config/log',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/config',
        outputFile: 'startup.dart',
        template: 'init/config/startup',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      // data
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
        outputDir: '$outputDirectory/data/network',
        outputFile: 'interceptor.dart',
        template: 'init/data/network/interceptor',
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

      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/data/service',
        outputFile: 'app_service.dart',
        template: 'init/data/service/app_service',
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

      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/model/api',
        outputFile: 'item.dart',
        template: 'init/model/api/item',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      // ui
      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/ui/main',
        outputFile: 'launch_screen.dart',
        template: 'init/ui/main/launch_screen',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      for (var page in ['home', 'setting', 'user']) {
        printer.writeln('$prefix ${await _createFile(
          outputDir: '$outputDirectory/ui/pages/$page',
          outputFile: '$page.logic.dart',
          template: 'init/ui/pages/$page/$page.logic',
          vars: {
            '': '',
          },
          overwrite: overwrite,
          dry: dry,
        )}');
        printer.writeln('$prefix ${await _createFile(
          outputDir: '$outputDirectory/ui/pages/$page',
          outputFile: '$page.view.dart',
          template: 'init/ui/pages/$page/$page.view',
          vars: {
            '': '',
          },
          overwrite: overwrite,
          dry: dry,
        )}');
      }

      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/ui/widgets',
        outputFile: 'none.dart',
        template: 'init/ui/widgets/none',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      printer.writeln('$prefix ${await _createFile(
        outputDir: '$outputDirectory/ui/widgets',
        outputFile: 'example_widget.dart',
        template: 'init/ui/widgets/example_widget',
        vars: {
          '': '',
        },
        overwrite: overwrite,
        dry: dry,
      )}');

      // root
      for (var main in ['main', 'main_dev_api', 'main_dev_mock', 'main_dev_prod']) {
        printer.writeln('$prefix ${await _createFile(
          outputDir: outputDirectory,
          outputFile: '$main.dart',
          template: 'init/$main',
          vars: {
            '': '',
          },
          overwrite: overwrite,
          dry: dry,
        )}');
      }

      for (var lang in ['string', 'string_th']) {
        printer.writeln('$prefix ${await _createFile(
          outputDir: 'assets/lang',
          outputFile: '$lang.lang.yaml',
          template: 'init/assets/lang/$lang.lang.yaml',
          vars: {
            '': '',
          },
          overwrite: overwrite,
          dry: dry,
        )}');
      }

      for (var model in ['item', 'items']) {
        printer.writeln('$prefix ${await _createFile(
          outputDir: 'assets/mock',
          outputFile: '$model.json',
          template: 'init/assets/mock/$model.json',
          vars: {
            '': '',
          },
          overwrite: overwrite,
          dry: dry,
        )}');
      }

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
    } catch (e) {
      printer.writeln(printer.red('[e] $e'));
      return 2;
    }

    printer.writeln('create project files -> done.');
    printer.writeln('please run `aves generate` to complete initialize.');

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
