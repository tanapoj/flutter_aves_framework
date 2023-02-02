import 'dart:io';

import '../command.dart';
import '../io/printer.dart';
import 'action.dart';

class GenerateAction extends Action {
  @override
  String get name => 'generate';

  @override
  bool checkCanExecCmd(Command input) {
    if (input.cmd == 'generate') return true;
    if (input.cmd == 'generate:model') return true;
    if (input.cmd == 'generate:injectable') return true;
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
