import 'dart:io';
import 'package:yaml/yaml.dart';

import '../command.dart';
import '../io/printer.dart';
import 'build.dart';
import 'init.dart';
import 'make_logic.dart';
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

Future<String> welcomeText() async {
  String flutterInfo = '';
  bool useFvm = false;

  try {
    var r = await Process.run('fvm', ['flutter', '--version']);
    flutterInfo = r.stdout;
    useFvm = true;
  } catch (e) {
    var r = await Process.run('flutter', ['--version']);
    flutterInfo = r.stdout;
  }

  return """Aves Flutter Framework for Build Flutter apps
Use fvm: ${useFvm ? printer.green('yes') : printer.red('no')}
$flutterInfo
Usage: 
    ${printer.green('command')} [options] [arguments]
    
Options:
    -h
    
All commands:
  ${printer.yellow('initial')}
    ${printer.green('init')}
  ${printer.yellow('build_runner')}
    ${printer.green('build')}
    ${printer.green('build:model')}
    ${printer.green('build:injectable')}
  ${printer.yellow('make')}
    ${printer.green('make:page')}
    ${printer.green('make:logic')}
    ${printer.green('make:view')}
    ${printer.green('make:model')}
""";
}

List<Action> allActions = [
  InitAction(),
  BuildAction(),
  MakePageAction(),
  MakeLogicAction(),
  MakeViewAction(),
];
