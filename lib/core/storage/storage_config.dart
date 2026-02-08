class StorageConfigException implements Exception {
  const StorageConfigException(this.error);

  final Object error;
}

abstract class StorageConfig {
  Future<String?> read({required String key});

  Future<void> write({required String key, required String value});

  Future<void> delete({required String key});

  Future<void> clear();
}
