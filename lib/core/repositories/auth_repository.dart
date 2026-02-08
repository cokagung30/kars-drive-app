import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/notification/notification.dart';
import 'package:kars_driver_app/core/storage/mapper/mapper.dart';
import 'package:kars_driver_app/core/storage/storage.dart';

class AuthFailure with EquatableMixin implements Exception {
  AuthFailure(this.error);

  final Object error;

  @override
  List<Object?> get props => [error];
}

class LoginUserFailure extends AuthFailure {
  LoginUserFailure(super.error);
}

class UnAuthenticatedMeFailure extends AuthFailure {
  UnAuthenticatedMeFailure(super.error);
}

class ForgotPasswordFailure extends AuthFailure {
  ForgotPasswordFailure(super.error);
}

class ResetPasswordFailure extends AuthFailure {
  ResetPasswordFailure(super.error);
}

class LogoutFailure extends AuthFailure {
  LogoutFailure(super.error);
}

class AuthRepository {
  AuthRepository({
    required AuthApi authApi,
    required UserStorage userStorage,
    required TokenStorage tokenStorage,
    required NotificationClient notificationClient,
  }) : _authApi = authApi,
       _userStorage = userStorage,
       _tokenStorage = tokenStorage,
       _notificationClient = notificationClient;

  final AuthApi _authApi;

  final UserStorage _userStorage;

  final TokenStorage _tokenStorage;

  final NotificationClient _notificationClient;

  Future<Auth> login(String email, String password) async {
    try {
      final fcmToken = await _notificationClient.getFcmToken();

      final auth = _authApi
          .login(email: email, password: password, fcmToken: fcmToken ?? '')
          .then((value) => value);

      return auth;
    } on LoginFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(LoginUserFailure(error), stackTrace);
    }
  }

  Future<dynamic> unAuthenticatedMe(Auth auth) async {
    try {
      await _userStorage.setViewer(auth.user.asEntity());
      await _tokenStorage.setToken(auth.accessToken);
    } on SetUserStorageFailure {
      rethrow;
    } on SetTokenStorageFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(
        UnAuthenticatedMeFailure(error),
        stackTrace,
      );
    }
  }

  Future<dynamic> forgotPassword(String email) async {
    try {
      await _authApi.forgotPassword(email);
    } on ForgotPasswordApiFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(ForgotPasswordFailure(error), stackTrace);
    }
  }

  Future<dynamic> resetPassword({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String otp,
  }) async {
    try {
      await _authApi.resetPassword(
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        otp: otp,
      );
    } on ResetPasswordApiFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(ResetPasswordFailure(error), stackTrace);
    }
  }

  Future<void> logout() async {
    try {
      await _authApi.logout();

      await _tokenStorage.clearToken();
      await _userStorage.clearViewer();
    } on ClearTokenStorageFailure {
      rethrow;
    } on ClearUserStorageFailure {
      rethrow;
    } on LogoutApiFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(LogoutFailure(error), stackTrace);
    }
  }
}
