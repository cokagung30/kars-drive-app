import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/storage/entity/entity.dart';

extension SettingEntityMapperExt on Setting {
  SettingEntity asEntity() {
    return SettingEntity(isIntroDone: isIntroDone);
  }
}

extension SettingMapperExt on SettingEntity {
  Setting toModel() {
    return Setting(isIntroDone: isIntroDone);
  }
}
