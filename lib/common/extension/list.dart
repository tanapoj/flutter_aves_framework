extension ListUtil<T> on List<T> {
  T? elementAtOrNull(int index) {
    return index >= 0 && index < length ? elementAt(index) : null;
  }

  T elementAtOrElse(int index, T defaultValue) {
    return index >= 0 && index < length ? elementAt(index) : defaultValue;
  }

  T? firstOrNull() {
    return isEmpty ? null : first;
  }

  T firstOrElse(T defaultValue) {
    return firstOrNull() ?? defaultValue;
  }

  T? firstWhereOrNull(bool Function(T element) predicate) {
    try {
      return isEmpty ? null : firstWhere(predicate, orElse: null);
    } catch (e) {
      return null;
    }
  }
}
