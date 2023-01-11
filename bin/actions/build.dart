import 'dart:io';

import 'package:aves_support/common/extension/list.dart';
import 'package:aves_support/common/extension/string.dart';
import 'package:recase/recase.dart';

import '../command.dart';
import '../io/printer.dart';
import '../io/template.dart';
import 'action.dart';

class BuildAction extends Action {
  @override
  String get name => 'build';

  @override
  bool checkCanExecCmd(Command input) {
    if (input.cmd == 'build') return true;
    if (input.cmd == 'build:model') return true;
    if (input.cmd == 'build:injectable') return true;
    return false;
  }

  @override
  bool verifyOptionsAndArguments(Command input) {
    return true;
  }

  @override
  exec(Command input) async {
    var avesConfig = await getAvesConfigYaml();
    bool useFvm = avesConfig['command'] == 'fvm';

    if (useFvm) {
      await _runSystemCommand(
        'fvm',
        ['flutter', 'pub', 'run', 'build_runner', 'build', '--delete-conflicting-outputs'],
      );
    } else {
      await _runSystemCommand(
        'flutter',
        ['pub', 'run', 'build_runner', 'build', '--delete-conflicting-outputs'],
      );
    }

    return 0;
  }
}

_runSystemCommand(String command, [List<String> args = const []]) async {
  final p = await Process.start(command, args);
  printer.writeln('${printer.blue('[i] exec command:')} ${printer.green(command)} ${printer.white(args.join(' '))}');
  await stdout.addStream(p.stdout);
}
