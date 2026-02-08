import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/storage/mapper/mapper.dart';
import 'package:kars_driver_app/core/storage/storage.dart';

class SettingFailure with EquatableMixin implements Exception {
  const SettingFailure(this.error);

  final Object error;

  @override
  List<Object> get props => [error];
}

class SaveSettingFailure extends SettingFailure {
  SaveSettingFailure(super.error);
}

class FetchSettingFailure extends SettingFailure {
  FetchSettingFailure(super.error);
}

class SettingRepository {
  SettingRepository({
    required SettingStorage settingStorage,
  }) : _settingStorage = settingStorage;

  final SettingStorage _settingStorage;

  Future<void> saveSetting(Setting setting) async {
    try {
      await _settingStorage.setSetting(setting.asEntity());
    } on SetSettingStorageFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(SaveSettingFailure(error), stackTrace);
    }
  }

  Future<Setting?> fetchSetting() async {
    try {
      final setting = await _settingStorage.fetchSetting();
      return setting?.toModel();
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(
        FetchSettingFailure(error),
        stackTrace,
      );
    }
  }

  Stream<Setting?> get setting {
    return _settingStorage.settingStream.map((event) => event?.toModel());
  }
}
