import 'dart:convert' as convert;

Map<String, dynamic> ensureJsonDecodeToMap(dynamic json) {
  if (json is Map<String, dynamic>) return json;
  return convert.jsonDecode('$json');
}

Iterable<dynamic> ensureJsonDecodeToIterable(dynamic json) {
  if (json is Iterable<dynamic>) return json;
  return convert.jsonDecode('$json');
}
