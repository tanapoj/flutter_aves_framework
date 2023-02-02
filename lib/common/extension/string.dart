import 'dart:math';

extension StringUtil on String {
  List<String> chunk(int size) {
    List<String> chunks = [];
    for (var i = 0; i < length; i += size) {
      chunks.add(substring(i, min(i + size, length)));
    }
    return chunks;
  }

  String toCapitalize({bool capitalizeOnlyFirstLetter = false}) {
    if (length == 0) return this;
    if (length == 1) return this[0].toUpperCase();
    if (capitalizeOnlyFirstLetter) {
      return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
