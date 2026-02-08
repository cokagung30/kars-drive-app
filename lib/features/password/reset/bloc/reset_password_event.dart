part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object?> get props => [];
}

class OtpChanged extends ResetPasswordEvent {
  const OtpChanged(this.otp);

  final String otp;

  @override
  List<Object?> get props => [otp];
}

class OtpFocused extends ResetPasswordEvent {
  const OtpFocused({required this.hasFocus});

  final bool hasFocus;

  @override
  List<Object?> get props => [hasFocus];
}

class PasswordChanged extends ResetPasswordEvent {
  const PasswordChanged(this.password);

  final String password;

  @override
  List<Object?> get props => [password];
}

class PasswordFocused extends ResetPasswordEvent {
  const PasswordFocused({required this.hasFocus});

  final bool hasFocus;

  @override
  List<Object?> get props => [hasFocus];
}

class ConfirmPasswordChanged extends ResetPasswordEvent {
  const ConfirmPasswordChanged(this.password);

  final String password;

  @override
  List<Object?> get props => [password];
}

class ConfirmPasswordFocused extends ResetPasswordEvent {
  const ConfirmPasswordFocused({required this.hasFocus});

  final bool hasFocus;

  @override
  List<Object?> get props => [hasFocus];
}

class FormSubmitted extends ResetPasswordEvent {
  const FormSubmitted();
}
