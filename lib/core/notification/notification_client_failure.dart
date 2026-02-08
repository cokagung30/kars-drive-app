import 'package:equatable/equatable.dart';

class NotificationClientFailure with EquatableMixin implements Exception {
  /// {@macro user_failure}
  const NotificationClientFailure(this.error);

  /// The error which was caught.
  final Object error;

  @override
  List<Object> get props => [error];
}

class FCMGetTokenFailure extends NotificationClientFailure {
  const FCMGetTokenFailure(super.error);
}

class FCMDeleteTokenFailure extends NotificationClientFailure {
  const FCMDeleteTokenFailure(super.error);
}
