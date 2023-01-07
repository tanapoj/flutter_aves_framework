import 'dart:io';
import 'package:aves_support/common/extension/list.dart';
import 'actions/action.dart';
import 'command.dart';
import 'io/printer.dart';

void main(List<String> arguments) async {
  printer.writeln(printer.green('Aves CLI start...'));

  if (arguments.isEmpty) {
    printer.writeln(await welcomeText());
    return;
  }

  var time = Stopwatch();
  time.start();

  var cmd = Command.parse(arguments);
  var argsString = cmd.arguments
      .map((key, value) {
        if (value == null) return MapEntry(key, printer.green(key));
        return MapEntry(key, '${printer.green(key)}: $value');
      })
      .values
      .join(', ');
  printer.writeln('${printer.blue('[i] run command:')} ${cmd.cmd}');
  printer.writeln('${printer.blue('    options:')} ${cmd.options.join(' ')}');
  printer.writeln('${printer.blue('    argument:')} $argsString');

  Action? action = allActions.firstWhereOrNull((action) {
    return action.checkCanExecCmd(cmd);
  });

  if (action == null) {
    printer.writeln(printer.red('Invalid arguments (0x1), no command for: $arguments'));
    exit(1);
  }

  if (!action.verifyOptionsAndArguments(cmd)) {
    printer.writeln(printer.red('Invalid arguments (0x2), options or args for command is invalid: $arguments'));
    exit(2);
  }

  var status = await action.exec(cmd);

  time.stop();
  if (status == 0) {
    printer.writeln(printer.green('-------------------------'));
    printer.writeln(printer.green('Time: ${time.elapsed.inMilliseconds} Milliseconds'));
    printer.writeln(printer.green('The End. 😎'));
  } else {
    printer.writeln(printer.red('-------------------------'));
    printer.writeln(printer.red('Time: ${time.elapsed.inMilliseconds} Milliseconds'));
    printer.writeln(printer.red('The End. 😱'));
  }
  exit(0);
}
