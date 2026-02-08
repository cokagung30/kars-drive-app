import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/storage/mapper/mapper.dart';
import 'package:kars_driver_app/core/storage/storage.dart';

class ProfileFailure with EquatableMixin implements Exception {
  ProfileFailure(this.error);

  final Object error;

  @override
  List<Object?> get props => [error];
}

class GetProfileFailure extends ProfileFailure {
  GetProfileFailure(super.error);
}

class UpdateProfileFailure extends ProfileFailure {
  UpdateProfileFailure(super.error);
}

class UpdatePasswordFailure extends ProfileFailure {
  UpdatePasswordFailure(super.error);
}

class UpdateStatusFailure extends ProfileFailure {
  UpdateStatusFailure(super.error);
}

class ProfileRepository {
  ProfileRepository({
    required ProfileApi profileApi,
    required UserStorage userStorage,
  }) : _profileApi = profileApi,
       _userStorage = userStorage;

  final ProfileApi _profileApi;

  final UserStorage _userStorage;

  Future<Profile?> getProfile() {
    try {
      final profile = _profileApi.profile().then((value) => value.data);

      return profile;
    } on GetProfileApiFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(GetProfileFailure(error), stackTrace);
    }
  }

  Future<void> updateProfile(
    UpdateProfileRequest request, {
    required bool lastStatusUser,
  }) async {
    try {
      await _profileApi.update(request);

      await _profileApi.profile().then((value) async {
        final profile = value.data;
        if (profile != null) {
          await _userStorage.setViewer(
            User(
              name: profile.name,
              email: profile.email,
              phone: profile.phone,
              avatar: profile.avatar,
              status: lastStatusUser,
            ).asEntity(),
          );
        }
      });
    } on SetUserStorageFailure {
      rethrow;
    } on GetProfileApiFailure {
      rethrow;
    } on UpdateProfileApiFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(UpdateProfileFailure(error), stackTrace);
    }
  }

  Future<void> updatePassword(
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      await _profileApi.updatePassword(newPassword, confirmPassword);
    } on UpdatePasswordApiFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(UpdatePasswordFailure(error), stackTrace);
    }
  }

  Future<void> updateStatus(String reason, num status) async {
    try {
      await _profileApi.updateStatus(reason, status);

      final user = await _userStorage.fetchViewer().then(
        (value) => value?.toModel(),
      );

      if (user != null) {
        final newUser = user.copyWith(status: status == 1);

        await _userStorage.setViewer(newUser.asEntity());
      }
    } on UpdateStatusApiFailure {
      rethrow;
    } on SetUserStorageFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(UpdateStatusFailure(error), stackTrace);
    }
  }
}
