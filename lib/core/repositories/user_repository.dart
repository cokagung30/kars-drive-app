import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/storage/mapper/mapper.dart';
import 'package:kars_driver_app/core/storage/storage.dart';

class UserFailure with EquatableMixin implements Exception {
  const UserFailure(this.error);

  final Object error;

  @override
  List<Object?> get props => [error];
}

class UserRepository {
  UserRepository({
    required UserStorage userStorage,
  }) : _userStorage = userStorage;

  final UserStorage _userStorage;

  Stream<User?> get user {
    return _userStorage.viewerStream.map((event) => event?.toModel());
  }
}
