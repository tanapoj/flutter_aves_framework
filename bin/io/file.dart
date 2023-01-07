import 'dart:io';

import '../actions/init.dart';
import 'printer.dart';

writeFile(
  String path,
  String content, {
  bool overwrite = false,
  bool runDry = false,
}) async {
  final Directory directory = Directory.current;
  final File file = File('${directory.path}/$path');

  if (!overwrite && await file.exists()) {
    throw ConflictingOutputsException(
      'File "$path" already exist. if you want to override file, use flag --overwrite',
    );
  }

  if (runDry) return;

  await file.writeAsString(content);
}

Future<String?> readFile(String path) async {
  try {
    final Directory directory = Directory.current;
    final File file = File('${directory.path}/$path');
    String content = await file.readAsString();
    return content;
  } catch (e) {
    printer.writeln(printer.red(e.toString()));
    return null;
  }
}

Future<String?> readFileObject(File file) async {
  try {
    String content = await file.readAsString();
    return content;
  } catch (e) {
    printer.writeln(printer.red(e.toString()));
    return null;
  }
}

// Future<String?> readBundle(String path) async {
//   try {
//     String content = await rootBundle.loadString('packages/aves/$path');
//     return content;
//   } catch (e) {
//     printer.writeln(printer.red(e.toString()));
//     return null;
//   }
// }

class ConflictingOutputsException extends Error {
  final String message;

  ConflictingOutputsException(this.message);

  @override
  String toString() {
    return message;
  }
}
