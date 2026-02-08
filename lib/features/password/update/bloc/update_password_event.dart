part of 'update_password_bloc.dart';

abstract class UpdatePasswordEvent extends Equatable {
  const UpdatePasswordEvent();

  @override
  List<Object?> get props => [];
}

class PasswordChanged extends UpdatePasswordEvent {
  const PasswordChanged(this.password);

  final String password;

  @override
  List<Object?> get props => [password];
}

class PasswordFocused extends UpdatePasswordEvent {
  const PasswordFocused({required this.isFocused});

  final bool isFocused;

  @override
  List<Object?> get props => [isFocused];
}

class ConfirmPasswordChanged extends UpdatePasswordEvent {
  const ConfirmPasswordChanged(this.password);

  final String password;

  @override
  List<Object?> get props => [password];
}

class ConfirmPasswordFocused extends UpdatePasswordEvent {
  const ConfirmPasswordFocused({required this.isFocused});

  final bool isFocused;

  @override
  List<Object?> get props => [isFocused];
}

class FormSubmitted extends UpdatePasswordEvent {
  const FormSubmitted();
}
