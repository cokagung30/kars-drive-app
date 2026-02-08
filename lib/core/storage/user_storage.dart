import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/storage/entity/entity.dart';
import 'package:kars_driver_app/core/storage/storage.dart';
import 'package:rxdart/rxdart.dart';

class UserStorageFailure with EquatableMixin implements Exception {
  const UserStorageFailure(this.error);

  final Object error;

  @override
  List<Object> get props => [error];
}

class SetUserStorageFailure extends UserStorageFailure {
  const SetUserStorageFailure(super.error);
}

class ClearUserStorageFailure extends UserStorageFailure {
  const ClearUserStorageFailure(super.error);
}

abstract class UserStorageKeys {
  static const user = '__app_user_key__';
}

class UserStorage {
  UserStorage({
    required StorageConfig storageConfig,
  }) : _storageConfig = storageConfig;

  final StorageConfig _storageConfig;

  final _userStream = BehaviorSubject<UserEntity?>();

  Stream<UserEntity?> get viewerStream {
    return _userStream.stream.asBroadcastStream();
  }

  Future<void> setViewer(UserEntity user) async {
    try {
      await _storageConfig.write(
        key: UserStorageKeys.user,
        value: json.encode(user.toJson()),
      );

      _userStream.add(user);
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(
        SetUserStorageFailure(error),
        stackTrace,
      );
    }
  }

  Future<UserEntity?> fetchViewer() async {
    final viewer = await _storageConfig.read(key: UserStorageKeys.user);

    if (viewer == null) return null;

    final entity = UserEntity.fromJson(
      jsonDecode(viewer) as Map<String, dynamic>,
    );

    _userStream.add(entity);

    return entity;
  }

  /// Fetches the number of times the app was opened value from Storage.
  Future<void> clearViewer() async {
    try {
      await _storageConfig.delete(key: UserStorageKeys.user);

      _userStream.add(null);
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(
        ClearUserStorageFailure(error),
        stackTrace,
      );
    }
  }
}
