import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';

class NotificationApiFailure with EquatableMixin implements Exception {
  NotificationApiFailure(this.error);

  final ServerExceptions error;

  @override
  List<Object?> get props => [error];
}

class FetchNotificationsApiFailure extends NotificationApiFailure {
  FetchNotificationsApiFailure(super.error);
}

class UpdateNotificationApiFailure extends NotificationApiFailure {
  UpdateNotificationApiFailure(super.error);
}

class NotificationApi {
  NotificationApi(this._dio);

  final Dio _dio;

  Future<List<NotificationMessage>> fetch() async {
    try {
      return await _dio
          .getWithDataCollection<NotificationMessage>(path: 'notification')
          .then((value) => value.data ?? []);
    } catch (error, stackTrace) {
      final exception = serverExceptionFrom(error);

      throw Error.throwWithStackTrace(
        FetchNotificationsApiFailure(exception),
        stackTrace,
      );
    }
  }

  Future<void> update(num id) async {
    try {
      await _dio.postWithData<dynamic>(
        path: 'notification/read/$id',
        request: {'is_read': '1'},
      );
    } catch (error, stackTrace) {
      final exception = serverExceptionFrom(error);

      throw Error.throwWithStackTrace(
        UpdateNotificationApiFailure(exception),
        stackTrace,
      );
    }
  }
}
