import 'dart:io';
// import 'package:flutter/services.dart';

import 'io/printer.dart';

class Command {
  final String cmd;
  final List<String> options;
  final Map<String, String?> arguments;

  Command({required this.cmd, required this.options, required this.arguments});

  factory Command.parse(List<String> inputs) {
    String cmd = inputs[0].toLowerCase();

    List<String> options = [];
    Map<String, String?> arguments = {};
    for (int i = 1; i < inputs.length; i++) {
      String input = inputs[i];
      if (input.startsWith('-')) {
        String? next = i + 1 < inputs.length ? inputs[i + 1] : null;
        if (next != null && !next.startsWith('-')) {
          arguments[input] = next;
          i++;
        } else {
          arguments[input] = null;
        }
      } else {
        options.add(input);
      }
    }
    return Command(cmd: cmd, options: options, arguments: arguments);
  }

  @override
  String toString() {
    return 'Command{cmd: $cmd, options: $options, arguments: $arguments}';
  }
}

_runSystemCommand(String command, [List<String> args = const []]) async {
  printer.writeln('${printer.blue('[i] exec command:')} ${printer.green(command)} ${printer.yellow(args.join(' '))}');
  final p = await Process.start(command, args);
  await stdout.addStream(p.stdout);
}
//
// List<Action1> allCommands = [
//   Action1(
//       cmd: 'test1',
//       subCommand: null,
//       options: 1,
//       arguments: [],
//       action: (List<String> arguments) async {
//         print('arguments=$arguments');
//
//         var name = arguments.length > 0 ? arguments[0] : 'test_name';
//         ReCase rc = ReCase(name);
//         var outputFileName = rc.snakeCase;
//         var outputClassName = rc.camelCase.toCapitalize();
//
//         var outputFile = 'lib/$outputFileName.test.dart';
//         printer.write('${printer.blue('[i] generate template for class:')} $outputClassName');
//         printer.write('${printer.blue('[i] create file:')} $outputFile');
//
//         var content = await makeTemplate('test', {
//           'className': outputClassName,
//         });
//
//         printer.write('-----\n$content\n-----');
//         if (content != null) {
//           try {
//             await writeFile(outputFile, content);
//             return 0;
//           } catch (e) {
//             printer.write(printer.red(e.toString()));
//             return 1;
//           }
//         }
//         return 1;
//       }),
//   Action1(
//       cmd: 'test2',
//       subCommand: null,
//       options: 1,
//       arguments: [],
//       action: (List<String> arguments) async {
//         await _runSystemCommand(
//           'fvm',
//           ['flutter', 'pub', 'run', 'build_runner', 'build', '--delete-conflicting-outputs'],
//         );
//
//         await Future.delayed(const Duration(seconds: 1));
//       }),
//   Action1(
//       cmd: 'build',
//       subCommand: null,
//       options: 1,
//       arguments: ['--check-conflicting-outputs'],
//       action: (List<String> arguments) async {
//         try {
//           var result = await Process.run(
//             'fvm',
//             ['flutter', 'pub', 'run', 'build_runner', 'build', '--delete-conflicting-outputs'],
//           );
//           stdout.write(result.stdout);
//           stderr.write(result.stderr);
//         } catch (e) {
//           var result = await Process.run(
//             'flutter',
//             ['pub', 'run', 'build_runner', 'build', '--delete-conflicting-outputs'],
//           );
//           stdout.write(result.stdout);
//           stderr.write(result.stderr);
//         }
//       }),
//   Action1(
//       cmd: 'build',
//       subCommand: 'all',
//       options: 1,
//       arguments: ['--check-conflicting-outputs'],
//       action: (List<String> arguments) {}),
// ];
