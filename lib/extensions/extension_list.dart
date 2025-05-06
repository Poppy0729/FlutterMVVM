extension ListExtensions<T> on List<T> {
  Iterable<T> whereWithIndex(bool Function(T element, int index) test) {
    final List<T> result = [];
    for (var i = 0; i < length; i++) {
      if (test(this[i], i)) {
        result.add(this[i]);
      }
    }
    return result;
  }
}