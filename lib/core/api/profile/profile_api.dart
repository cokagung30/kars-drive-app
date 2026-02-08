import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';

class ProfileApiFailure extends Equatable {
  const ProfileApiFailure(this.error);

  final ServerExceptions error;

  @override
  List<Object?> get props => [error];
}

class GetProfileApiFailure extends ProfileApiFailure {
  const GetProfileApiFailure(super.error);
}

class UpdateProfileApiFailure extends ProfileApiFailure {
  const UpdateProfileApiFailure(super.error);
}

class UpdatePasswordApiFailure extends ProfileApiFailure {
  const UpdatePasswordApiFailure(super.error);
}

class UpdateStatusApiFailure extends ProfileApiFailure {
  const UpdateStatusApiFailure(super.error);
}

class ProfileApi {
  ProfileApi(this._dio);

  final Dio _dio;

  Future<Data<Profile>> profile() async {
    try {
      return await _dio.getWithData(path: 'profile');
    } catch (error, stackTrace) {
      final exception = serverExceptionFrom(error);

      throw Error.throwWithStackTrace(
        GetProfileApiFailure(exception),
        stackTrace,
      );
    }
  }

  Future<dynamic> update(UpdateProfileRequest request) async {
    try {
      return await _dio.postWithMultipartNullData(
        path: 'profile/update',
        request: request.toFormData(),
      );
    } catch (error, stackTrace) {
      final exception = serverExceptionFrom(error);

      throw Error.throwWithStackTrace(
        UpdateProfileApiFailure(exception),
        stackTrace,
      );
    }
  }

  Future<dynamic> updatePassword(
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      return await _dio.postWithData<dynamic>(
        path: 'change-password',
        request: {
          'password': newPassword,
          'password_confirmation': confirmPassword,
        },
      );
    } catch (error, stackTrace) {
      final exception = serverExceptionFrom(error);

      throw Error.throwWithStackTrace(
        UpdatePasswordApiFailure(exception),
        stackTrace,
      );
    }
  }

  Future<dynamic> updateStatus(String reason, num status) async {
    try {
      await _dio.postWithData<dynamic>(
        path: 'driver/manage',
        request: {
          'reason': reason,
          'is_available': status,
        },
      );
    } catch (error, stackTrace) {
      final exception = serverExceptionFrom(error);

      throw Error.throwWithStackTrace(
        UpdateStatusApiFailure(exception),
        stackTrace,
      );
    }
  }
}
