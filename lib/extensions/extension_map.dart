extension AppendToListOnMapWithListsExtension<K, V> on Map<K, List<V>> {
  void appendToList(K key, V value) =>
      update(key, (list) => list..add(value), ifAbsent: () => [value]);
}