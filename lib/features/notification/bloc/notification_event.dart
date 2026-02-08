part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class NotificationFetched extends NotificationEvent {
  const NotificationFetched();
}

class NotificationUpdated extends NotificationEvent {
  const NotificationUpdated(this.id);

  final num id;

  @override
  List<Object?> get props => [id];
}
