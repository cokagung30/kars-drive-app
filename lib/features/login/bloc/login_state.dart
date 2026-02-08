part of 'login_bloc.dart';

class LoginState with FormzMixin, EquatableMixin {
  const LoginState({
    this.email = const EmailFormz.pure(),
    this.password = const PasswordFormz.pure(),
    this.emailHasFocus = false,
    this.passwordHasFocus = false,
    this.status = LoadStatus.initial,
    this.errorMessage,
  });

  final bool emailHasFocus;

  final bool passwordHasFocus;

  final EmailFormz email;

  final PasswordFormz password;

  final LoadStatus status;

  final String? errorMessage;

  bool get isLoading => status == LoadStatus.loading;

  @override
  bool get isValid => email.value.isNotEmpty && password.value.isNotEmpty;

  LoginState copyWith({
    EmailFormz? email,
    PasswordFormz? password,
    bool? emailHasFocus,
    bool? passwordHasFocus,
    LoadStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailHasFocus: emailHasFocus ?? this.emailHasFocus,
      passwordHasFocus: passwordHasFocus ?? this.passwordHasFocus,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    emailHasFocus,
    passwordHasFocus,
    status,
    errorMessage,
  ];

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [email, password];
}
