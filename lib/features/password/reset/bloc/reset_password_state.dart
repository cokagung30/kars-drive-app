part of 'reset_password_bloc.dart';

class ResetPasswordState with FormzMixin, EquatableMixin {
  ResetPasswordState({
    this.hasOtpFocused = false,
    this.hasPasswordFocused = false,
    this.hasConfirmPasswordFocused = false,
    this.otp = const OtpFormz.pure(),
    this.email = const EmailFormz.pure(),
    this.password = const PasswordFormz.pure(),
    this.confirmPassword = const ConfirmPasswordFormz.pure(),
    this.submitStatus = LoadStatus.initial,
    this.errorMessage = '',
  });

  final bool hasOtpFocused;

  final bool hasPasswordFocused;

  final bool hasConfirmPasswordFocused;

  final EmailFormz email;

  final OtpFormz otp;

  final PasswordFormz password;

  final ConfirmPasswordFormz confirmPassword;

  final LoadStatus submitStatus;

  final String? errorMessage;

  @override
  bool get isValid {
    return otp.isValid &&
        email.isValid &&
        password.isValid &&
        confirmPassword.isValid;
  }

  ResetPasswordState copyWith({
    bool? hasOtpFocused,
    bool? hasPasswordFocused,
    bool? hasConfirmPasswordFocused,
    OtpFormz? otp,
    EmailFormz? email,
    PasswordFormz? password,
    ConfirmPasswordFormz? confirmPassword,
    LoadStatus? submitStatus,
    String? errorMessage,
  }) {
    return ResetPasswordState(
      hasOtpFocused: hasOtpFocused ?? this.hasOtpFocused,
      hasPasswordFocused: hasPasswordFocused ?? this.hasPasswordFocused,
      hasConfirmPasswordFocused:
          hasConfirmPasswordFocused ?? this.hasConfirmPasswordFocused,
      otp: otp ?? this.otp,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      submitStatus: submitStatus ?? this.submitStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    hasOtpFocused,
    hasPasswordFocused,
    hasConfirmPasswordFocused,
    otp,
    password,
    confirmPassword,
    submitStatus,
    errorMessage,
  ];

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [
    otp,
    email,
    password,
    confirmPassword,
  ];
}
