import 'dart:io';

import 'io/file.dart';
import 'io/printer.dart';

void main(List<String> arguments) async {
  const rootPath = 'assets/stub/';
  final dir = Directory(rootPath);
  final List<File> files = [];
  await traversal(dir, files);
  var m = await getFilesContent(files, rootPath);
  String output = 'Map<String,String> template = {\n';
  for (var entry in m.entries) {
    var name = entry.key;
    var content = entry.value.replaceAll('\$', '\\\$');
    printer.writeln('- $name');
    output += '"$name": """$content""",\n';
  }
  output += "};";
  writeFile('bin/assets/stub/template.g.dart', output, overwrite: true);
}

Future<void> traversal(Directory root, List<File> recorder) async {
  final List<FileSystemEntity> entities = await root.list().toList();
  var dirs = entities.whereType<Directory>().toList();
  var files = entities.whereType<File>().where((f) => f.path.endsWith('.template')).toList();
  recorder.addAll(files);
  for (var dir in dirs) {
    await traversal(dir, recorder);
  }
}

Future<Map<String, String>> getFilesContent(List<File> files, String rootPath) async {
  Map<String, String> m = {};
  for (var file in files) {
    String n = file.path.replaceAll(rootPath, '');
    String c = await readFileObject(file) ?? '';
    m[n] = c;
  }
  return m;
}
