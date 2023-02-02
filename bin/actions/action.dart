import 'dart:io';
import 'package:yaml/yaml.dart';

import '../command.dart';
import '../io/printer.dart';
import 'generate.dart';
import 'init.dart';
import 'init_config.dart';
import 'make_logic.dart';
import 'make_model.dart';
import 'make_page.dart';
import 'make_view.dart';

abstract class Action {
  String get name;

  bool checkCanExecCmd(Command input);

  bool verifyOptionsAndArguments(Command input);

  dynamic exec(Command input);
}

Future<Map> getProjectYaml() async {
  File f = File('pubspec.yaml');
  String text = await f.readAsString();
  Map yaml = loadYaml(text);
  return yaml;
}

Future<Map> getAvesConfigYaml() async {
  File f = File('.aves/aves_config.yaml');
  if (!f.existsSync()) return {};
  String text = await f.readAsString();
  Map yaml = loadYaml(text);
  return yaml;
}

class TemplateInfo {
  final String projectName;
  final String author;
  final String createdAt;

  TemplateInfo(this.projectName, this.author, this.createdAt);

  static TemplateInfo? _instance;

  static Future<TemplateInfo> instance() async {
    if (_instance != null) return Future.value(_instance);

    var yaml = await getProjectYaml();
    String projectName = yaml['name'] ?? '';

    DateTime today = DateTime.now();
    String createdAt =
        "${today.year.toString()}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    late String author;
    try {
      author = (await Process.run('whoami', [])).stdout.toString().trim();
    } catch (e) {
      author = '';
    }

    return _instance = TemplateInfo(projectName, author, createdAt);
  }
}

/// Help Text

Future<String> welcomeText({required bool useFvm}) async {
  String flutterInfo = '';

  if (useFvm) {
    var r = await Process.run('fvm', ['flutter', '--version']);
    flutterInfo = r.stdout;
  } else {
    var r = await Process.run('flutter', ['--version']);
    flutterInfo = r.stdout;
  }

  return """Aves Flutter Framework for Build Flutter apps
Use fvm: ${useFvm ? printer.green('yes') : printer.red('no')}
$flutterInfo
Usage: 
    ${printer.green('command')} [options] [--arguments]
    
All commands:
  ${printer.yellow('initial')}
    ${printer.green('init')} [${printer.blue('--dir')} lib] [${printer.blue('--overwrite')}] [${printer.blue('--dry')}]
    ${printer.green('init:config')} [${printer.blue('--overwrite')}] [${printer.blue('--dry')}] [${printer.blue('--use-fvm')}]
  ${printer.yellow('build_runner')}
    ${printer.green('generate')}
    ${printer.green('generate:model')}
    ${printer.green('generate:injectable')}
  ${printer.yellow('make')}
    ${printer.green('make:page')}  page_name   [${printer.blue('--dir')} lib/ui/pages] [${printer.blue('--overwrite')}] [${printer.blue('--dry')}] [${printer.blue('--blank')}]
    ${printer.green('make:logic')} logic_name  [${printer.blue('--dir')} lib/ui/pages] [${printer.blue('--overwrite')}] [${printer.blue('--dry')}] [${printer.blue('--blank')}]
    ${printer.green('make:view')}  view_name   [${printer.blue('--dir')} lib/ui/pages] [${printer.blue('--overwrite')}] [${printer.blue('--dry')}] [${printer.blue('--blank')}]
    ${printer.green('make:model')} model_name  [${printer.blue('--dir')} lib/model]    [${printer.blue('--overwrite')}] [${printer.blue('--dry')}] [${printer.blue('--no-suffix')}]
""";
}

List<Action> allActions = [
  InitAction(),
  InitConfigAction(),
  GenerateAction(),
  MakePageAction(),
  MakeLogicAction(),
  MakeViewAction(),
  MakeModelAction(),
];
