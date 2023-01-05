import '../actions/action.dart';
import '../assets/stub/template.g.dart';

Future<String> makeTemplate(String stubName, Map<String, dynamic> vars) async {
  var info = await TemplateInfo.instance();
  vars.addAll({
    'projectName': info.projectName,
    'author': info.author,
    'createdAt': info.createdAt,
  });
  // var content = await readFile('assets/stub/$stubName.template');
  var content = template['$stubName.template'] ?? '';
  for (var entry in vars.entries) {
    var name = entry.key;
    var value = entry.value;
    content = content.replaceAll('{{#$name}}', value);
  }
  return content;
}
