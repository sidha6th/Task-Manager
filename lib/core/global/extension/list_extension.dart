extension ListExtension<T> on List<T> {
  int indexWhereWithWithFallbackIndex(bool Function(T element) cb,
      {int fallbackIndex = 0}) {
    final index = indexWhere(cb);
    if (index == -1) return fallbackIndex;
    return index;
  }
}
