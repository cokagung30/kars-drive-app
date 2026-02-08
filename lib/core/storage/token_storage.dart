import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/storage/storage.dart';

class TokenStorageFailure with EquatableMixin implements Exception {
  const TokenStorageFailure(this.error);

  final Object error;

  @override
  List<Object?> get props => [error];
}

class SetTokenStorageFailure extends TokenStorageFailure {
  const SetTokenStorageFailure(super.error);
}

class ClearTokenStorageFailure extends TokenStorageFailure {
  const ClearTokenStorageFailure(super.error);
}

abstract class TokenStorageKeys {
  static const token = '__app_token_key__';
}

class TokenStorage {
  TokenStorage({
    required StorageConfig storageConfig,
  }) : _storageConfig = storageConfig;

  final StorageConfig _storageConfig;

  Future<void> setToken(String bearerToken) async {
    try {
      await _storageConfig.write(
        key: TokenStorageKeys.token,
        value: bearerToken,
      );
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(
        SetTokenStorageFailure(error),
        stackTrace,
      );
    }
  }

  Future<String?> fetchToken() async {
    final token = await _storageConfig.read(key: TokenStorageKeys.token);
    return token;
  }

  Future<void> clearToken() async {
    try {
      await _storageConfig.delete(key: TokenStorageKeys.token);
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(
        ClearTokenStorageFailure(error),
        stackTrace,
      );
    }
  }
}
