import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/repositories/repositories.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/injection/injection.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc({required String email})
    : _repository = inject(),
      super(ResetPasswordState(email: EmailFormz.pure(email))) {
    on<OtpChanged>(_onOtpChanged);
    on<OtpFocused>(_onOtpFocused);
    on<PasswordChanged>(_onPasswordChanged);
    on<PasswordFocused>(_onPasswordFocused);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<ConfirmPasswordFocused>(_onConfirmPasswordFocused);
    on<FormSubmitted>(_onFormSubmitted);
  }

  final AuthRepository _repository;

  void _onOtpChanged(OtpChanged event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(otp: OtpFormz.pure(event.otp)));
  }

  void _onOtpFocused(OtpFocused event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(hasOtpFocused: event.hasFocus));
  }

  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<ResetPasswordState> emit,
  ) {
    emit(state.copyWith(password: PasswordFormz.pure(value: event.password)));
  }

  void _onPasswordFocused(
    PasswordFocused event,
    Emitter<ResetPasswordState> emit,
  ) {
    emit(state.copyWith(hasPasswordFocused: event.hasFocus));
  }

  void _onConfirmPasswordChanged(
    ConfirmPasswordChanged event,
    Emitter<ResetPasswordState> emit,
  ) {
    emit(
      state.copyWith(
        confirmPassword: ConfirmPasswordFormz.pure(value: event.password),
      ),
    );
  }

  void _onConfirmPasswordFocused(
    ConfirmPasswordFocused event,
    Emitter<ResetPasswordState> emit,
  ) {
    emit(state.copyWith(hasConfirmPasswordFocused: event.hasFocus));
  }

  Future<void> _onFormSubmitted(
    FormSubmitted _,
    Emitter<ResetPasswordState> emit,
  ) async {
    final otp = OtpFormz.dirty(state.otp.value);
    final email = EmailFormz.dirty(state.email.value);
    final password = PasswordFormz.dirty(
      value: state.password.value,
      minLength: 8,
    );
    final confirmPassword = ConfirmPasswordFormz.dirty(
      password: password.value,
      value: state.confirmPassword.value,
    );

    if (!state.isValid) {
      emit(
        state.copyWith(
          otp: otp,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
        ),
      );

      return;
    }

    emit(state.copyWith(submitStatus: LoadStatus.loading));

    try {
      await _repository.resetPassword(
        email: email.value,
        password: password.value,
        passwordConfirmation: confirmPassword.value,
        otp: otp.value,
      );

      emit(state.copyWith(submitStatus: LoadStatus.success));
    } on ResetPasswordApiFailure catch (error, stackTrace) {
      final exception = error.error;
      final errorMessage = exception.entity?.message;

      emit(
        state.copyWith(
          errorMessage: errorMessage,
          submitStatus: LoadStatus.error,
        ),
      );

      addError(error, stackTrace);
    } catch (error, stackTrace) {
      emit(
        state.copyWith(
          submitStatus: LoadStatus.error,
          errorMessage: 'Terjadi kesalahan, silahkan coba lagi',
        ),
      );

      addError(error, stackTrace);
    }
  }
}
