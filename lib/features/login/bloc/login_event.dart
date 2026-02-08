part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class EmailChanged extends LoginEvent {
  const EmailChanged(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

class PasswordChanged extends LoginEvent {
  const PasswordChanged(this.password);

  final String password;

  @override
  List<Object?> get props => [password];
}

class EmailFocused extends LoginEvent {
  const EmailFocused({required this.hasFocus});

  final bool hasFocus;

  @override
  List<Object?> get props => [hasFocus];
}

class PasswordFocused extends LoginEvent {
  const PasswordFocused({required this.hasFocus});

  final bool hasFocus;

  @override
  List<Object?> get props => [hasFocus];
}

class FormSubmitted extends LoginEvent {
  const FormSubmitted();
}
