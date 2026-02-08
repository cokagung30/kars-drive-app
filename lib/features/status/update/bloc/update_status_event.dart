part of 'update_status_bloc.dart';

abstract class UpdateStatusEvent extends Equatable {
  const UpdateStatusEvent();

  @override
  List<Object?> get props => [];
}

class ReasonChanged extends UpdateStatusEvent {
  const ReasonChanged(this.reason);

  final String reason;

  @override
  List<Object?> get props => [reason];
}

class ReasonFocused extends UpdateStatusEvent {
  const ReasonFocused({required this.isFocused});

  final bool isFocused;

  @override
  List<Object?> get props => [isFocused];
}

class FormSubmitted extends UpdateStatusEvent {
  const FormSubmitted();
}
