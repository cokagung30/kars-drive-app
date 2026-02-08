import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/models/models.dart';

class NotificationFailure extends Equatable {
  const NotificationFailure(this.error);

  final Object error;

  @override
  List<Object?> get props => [error];
}

class FetchNotificationsFailure extends NotificationFailure {
  const FetchNotificationsFailure(super.error);
}

class UpdateNotificationFailure extends NotificationFailure {
  const UpdateNotificationFailure(super.error);
}

class NotificationRepository {
  NotificationRepository({required NotificationApi notificationApi})
    : _notificationApi = notificationApi;

  final NotificationApi _notificationApi;

  Future<List<NotificationMessage>> fetch() async {
    try {
      final notifications = await _notificationApi.fetch();

      return notifications;
    } on FetchNotificationsApiFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(
        FetchNotificationsFailure(error),
        stackTrace,
      );
    }
  }

  Future<void> update(num id) async {
    try {
      await _notificationApi.update(id);
    } on UpdateNotificationApiFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(
        UpdateNotificationFailure(error),
        stackTrace,
      );
    }
  }
}
