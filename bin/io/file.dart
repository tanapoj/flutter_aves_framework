import 'dart:io';

import 'printer.dart';

writeFile(String path, String content) async {
  final Directory directory = Directory.current;
  final File file = File('${directory.path}/$path');
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
