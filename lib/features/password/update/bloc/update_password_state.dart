part of 'update_password_bloc.dart';

class UpdatePasswordState with FormzMixin, EquatableMixin {
  const UpdatePasswordState({
    this.newPassword = const PasswordFormz.pure(),
    this.confirmPassword = const ConfirmPasswordFormz.pure(),
    this.submitStatus = LoadStatus.initial,
    this.hasNewPasswordFocus = false,
    this.hasConfirmPasswordFocus = false,
  });

  final bool hasNewPasswordFocus;

  final bool hasConfirmPasswordFocus;

  final PasswordFormz newPassword;

  final ConfirmPasswordFormz confirmPassword;

  final LoadStatus submitStatus;

  @override
  bool get isValid =>
      newPassword.value.isNotEmpty && confirmPassword.value.isNotEmpty;

  UpdatePasswordState copyWith({
    PasswordFormz? newPassword,
    ConfirmPasswordFormz? confirmPassword,
    LoadStatus? submitStatus,
    bool? hasNewPasswordFocus,
    bool? hasConfirmPasswordFocus,
  }) {
    return UpdatePasswordState(
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      submitStatus: submitStatus ?? this.submitStatus,
      hasNewPasswordFocus: hasNewPasswordFocus ?? this.hasNewPasswordFocus,
      hasConfirmPasswordFocus:
          hasNewPasswordFocus ?? this.hasConfirmPasswordFocus,
    );
  }

  @override
  List<Object?> get props => [
    newPassword,
    confirmPassword,
    submitStatus,
    hasNewPasswordFocus,
    hasConfirmPasswordFocus,
  ];

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [
    newPassword,
    confirmPassword,
  ];
}
