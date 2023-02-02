import 'dart:io';
import 'package:yaml/yaml.dart' show loadYaml;

writeFile(String path, String content) async {
  final Directory directory = Directory.current;
  final File file = File('${directory.path}/$path');
  await file.writeAsString(content);
}

Future<String?> readFile(String path, {bool throwExceptionIfExist = false}) async {
  try {
    final Directory directory = Directory.current;
    final File file = File('${directory.path}/$path');
    String content = await file.readAsString();
    return content;
  } catch (e) {
    if (throwExceptionIfExist) rethrow;
    return null;
  }
}

Future<Map> getYaml({String path = 'pubspec.yaml'}) async {
  File f = File(path);
  String text = await f.readAsString();
  Map yaml = loadYaml(text);
  return yaml;
}
