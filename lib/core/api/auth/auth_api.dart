import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';

class AuthApiFailure with EquatableMixin implements Exception {
  const AuthApiFailure(this.error);

  final ServerExceptions error;

  @override
  List<Object?> get props => [error];
}

class LoginFailure extends AuthApiFailure {
  LoginFailure(super.error);
}

class ForgotPasswordApiFailure extends AuthApiFailure {
  ForgotPasswordApiFailure(super.error);
}

class ResetPasswordApiFailure extends AuthApiFailure {
  ResetPasswordApiFailure(super.error);
}

class LogoutApiFailure extends AuthApiFailure {
  LogoutApiFailure(super.error);
}

class AuthApi {
  AuthApi(this._dio);

  final Dio _dio;

  Future<Auth> login({
    required String email,
    required String password,
    required String fcmToken,
  }) async {
    try {
      return await _dio
          .postWithData<Auth>(
            path: 'login-driver',
            request: {
              'email': email,
              'password': password,
              'fcm': fcmToken,
            },
          )
          .then((value) => value.data!);
    } catch (error, stackTrace) {
      final exception = serverExceptionFrom(error);

      throw Error.throwWithStackTrace(LoginFailure(exception), stackTrace);
    }
  }

  Future<dynamic> forgotPassword(String email) async {
    try {
      return await _dio.postWithData<dynamic>(
        path: 'forgot-password',
        request: {'email': email},
      );
    } catch (error, stackTrace) {
      final exception = serverExceptionFrom(error);

      throw Error.throwWithStackTrace(
        ForgotPasswordApiFailure(exception),
        stackTrace,
      );
    }
  }

  Future<dynamic> resetPassword({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String otp,
  }) async {
    try {
      return await _dio.postWithData<dynamic>(
        path: 'reset-password',
        request: {
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'otp': otp,
        },
      );
    } catch (error, stackTrace) {
      final exception = serverExceptionFrom(error);

      throw Error.throwWithStackTrace(
        ResetPasswordApiFailure(exception),
        stackTrace,
      );
    }
  }

  Future<dynamic> logout() async {
    try {
      await _dio.getWithData<dynamic>(path: 'logout');
    } catch (error, stackTrace) {
      final exception = serverExceptionFrom(error);

      throw Error.throwWithStackTrace(LogoutApiFailure(exception), stackTrace);
    }
  }
}
