import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/models/load_status.dart';
import 'package:kars_driver_app/core/repositories/repositories.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/injection/injection.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({AuthRepository? authRepository})
    : _authRepository = authRepository ?? inject(),
      super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<EmailFocused>(_onEmailFocused);
    on<PasswordFocused>(_onPasswordFocused);
    on<FormSubmitted>(_onFormSubmitted);
  }

  final AuthRepository _authRepository;

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: EmailFormz.pure(event.email)));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: PasswordFormz.pure(value: event.password)));
  }

  void _onEmailFocused(EmailFocused event, Emitter<LoginState> emit) {
    emit(state.copyWith(emailHasFocus: event.hasFocus));
  }

  void _onPasswordFocused(PasswordFocused event, Emitter<LoginState> emit) {
    emit(state.copyWith(passwordHasFocus: event.hasFocus));
  }

  Future<void> _onFormSubmitted(
    FormSubmitted _,
    Emitter<LoginState> emit,
  ) async {
    final email = EmailFormz.dirty(state.email.value);
    final password = PasswordFormz.dirty(value: state.password.value);

    if (!state.isValid) {
      emit(state.copyWith(email: email, password: password));

      return;
    }

    emit(state.copyWith(status: LoadStatus.loading));

    try {
      final auth = await _authRepository.login(email.value, password.value);

      await _authRepository.unAuthenticatedMe(auth);

      emit(state.copyWith(status: LoadStatus.success));
    } on LoginFailure catch (error, stackTrace) {
      final exception = error.error;
      final errorMessage = exception.entity?.message;

      emit(
        state.copyWith(errorMessage: errorMessage, status: LoadStatus.error),
      );

      addError(error, stackTrace);
    } catch (error, stackTrace) {
      emit(state.copyWith(status: LoadStatus.error));
      addError(error, stackTrace);
    }
  }
}
