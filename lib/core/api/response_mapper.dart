abstract class Mapper<T, K> {
  T asModel(K data);

  List<T> asModels(List<K>? data) {
    final items = data ?? [];
    return items.map(asModel).toList();
  }
}

abstract class MapperParam<T, K, P> {
  T asModel(K data, P param);

  List<T> asModels(List<K> data, P param) {
    throw UnimplementedError('convert to models not implemented');
  }
}
