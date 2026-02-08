part of 'forgot_password_bloc.dart';

class ForgotPasswordState with FormzMixin, EquatableMixin {
  ForgotPasswordState({
    this.hasEmailFocused = false,
    this.email = const EmailFormz.pure(),
    this.submitStatus = LoadStatus.initial,
    this.errorMesage,
  });

  final bool hasEmailFocused;

  final EmailFormz email;

  final LoadStatus submitStatus;

  final String? errorMesage;

  @override
  bool get isValid => email.value.isNotEmpty;

  ForgotPasswordState copyWith({
    EmailFormz? email,
    LoadStatus? submitStatus,
    bool? hasEmailFocused,
    String? errorMesage,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      submitStatus: submitStatus ?? this.submitStatus,
      hasEmailFocused: hasEmailFocused ?? this.hasEmailFocused,
      errorMesage: errorMesage ?? this.errorMesage,
    );
  }

  @override
  List<Object?> get props => [
    email,
    submitStatus,
    hasEmailFocused,
    errorMesage,
  ];

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [email];
}
