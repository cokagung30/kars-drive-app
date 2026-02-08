import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/storage/entity/entity.dart';
import 'package:kars_driver_app/core/storage/storage.dart';
import 'package:rxdart/rxdart.dart';

class SettingStorageFailure with EquatableMixin implements Exception {
  const SettingStorageFailure(this.error);

  final Object error;

  @override
  List<Object> get props => [error];
}

class SetSettingStorageFailure extends SettingStorageFailure {
  SetSettingStorageFailure(super.error);
}

class ClearSettingStorageFailure extends SettingStorageFailure {
  const ClearSettingStorageFailure(super.error);
}

abstract class SettingStorageKeys {
  static const setting = '__app_setting_key__';
}

class SettingStorage {
  SettingStorage({
    required StorageConfig storageConfig,
  }) : _storageConfig = storageConfig;

  final StorageConfig _storageConfig;

  final _settingStream = BehaviorSubject<SettingEntity?>();

  Stream<SettingEntity?> get settingStream {
    return _settingStream.stream.asBroadcastStream();
  }

  Future<void> setSetting(SettingEntity setting) async {
    try {
      await _storageConfig.write(
        key: SettingStorageKeys.setting,
        value: json.encode(setting.toJson()),
      );
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(
        SetSettingStorageFailure(error),
        stackTrace,
      );
    }
  }

  Future<SettingEntity?> fetchSetting() async {
    final setting = await _storageConfig.read(key: SettingStorageKeys.setting);

    if (setting == null) return null;

    final entity = SettingEntity.fromJson(
      jsonDecode(setting) as Map<String, dynamic>,
    );

    _settingStream.add(entity);

    return entity;
  }

  Future<void> clearSetting() async {
    try {
      await _storageConfig.delete(key: SettingStorageKeys.setting);

      _settingStream.add(null);
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(
        ClearSettingStorageFailure(error),
        stackTrace,
      );
    }
  }
}
