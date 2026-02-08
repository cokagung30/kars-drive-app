import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/repositories/repositories.dart';
import 'package:kars_driver_app/injection/injection.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc()
    : _repository = inject(),
      super(const NotificationState()) {
    on<NotificationFetched>(_onNotificationFetched);
    on<NotificationUpdated>(_onNotificationUpdated);
  }

  final NotificationRepository _repository;

  Future<void> _onNotificationFetched(
    NotificationFetched _,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(fetchingStatus: LoadStatus.loading));

    try {
      final notifications = await _repository.fetch();

      emit(
        state.copyWith(
          notifications: notifications,
          fetchingStatus: LoadStatus.success,
        ),
      );
    } catch (error, stackTrace) {
      emit(state.copyWith(fetchingStatus: LoadStatus.error));

      addError(error, stackTrace);
    }
  }

  Future<void> _onNotificationUpdated(
    NotificationUpdated event,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(updateStatus: LoadStatus.loading));

    try {
      final notifications = List<NotificationMessage>.from(state.notifications);
      final newNotifications = notifications.map((notification) {
        if (notification.id == event.id) {
          return notification.copyWith(isRead: true);
        }

        return notification;
      }).toList();

      emit(state.copyWith(notifications: newNotifications));

      await _repository.update(event.id);

      emit(state.copyWith(updateStatus: LoadStatus.success));
    } catch (error, stackTrace) {
      emit(state.copyWith(updateStatus: LoadStatus.error));

      addError(error, stackTrace);
    }
  }
}
