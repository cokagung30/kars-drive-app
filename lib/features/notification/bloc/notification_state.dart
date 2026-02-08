part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  const NotificationState({
    this.fetchingStatus = LoadStatus.initial,
    this.updateStatus = LoadStatus.initial,
    this.notifications = const [],
  });

  final LoadStatus fetchingStatus;

  final LoadStatus updateStatus;

  final List<NotificationMessage> notifications;

  NotificationState copyWith({
    LoadStatus? fetchingStatus,
    LoadStatus? updateStatus,
    List<NotificationMessage>? notifications,
  }) {
    return NotificationState(
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
      updateStatus: updateStatus ?? this.updateStatus,
      notifications: notifications ?? this.notifications,
    );
  }

  @override
  List<Object?> get props => [fetchingStatus, updateStatus, notifications];
}
