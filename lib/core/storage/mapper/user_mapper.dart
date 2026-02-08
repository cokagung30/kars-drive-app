import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/storage/entity/entity.dart';

extension UserEntityMapperExt on User {
  UserEntity asEntity() {
    return UserEntity(
      name: name,
      email: email,
      phone: phone,
      avatar: avatar,
      status: status,
    );
  }
}

extension UserMapperExt on UserEntity {
  User toModel() {
    return User(
      name: name,
      email: email,
      phone: phone,
      avatar: avatar,
      status: status,
    );
  }
}
