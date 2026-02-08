import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/repositories/repositories.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/injection/injection.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : _repository = inject(), super(ForgotPasswordState()) {
    on<EmailChanged>(_onEmailChanged);
    on<EmailFocused>(_onEmailFocused);
    on<FormSubmitted>(_onFormSubmitted);
  }

  final AuthRepository _repository;

  void _onEmailChanged(
    EmailChanged event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(state.copyWith(email: EmailFormz.pure(event.email)));
  }

  void _onEmailFocused(
    EmailFocused event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(state.copyWith(hasEmailFocused: event.hasFocus));
  }

  Future<void> _onFormSubmitted(
    FormSubmitted _,
    Emitter<ForgotPasswordState> emit,
  ) async {
    final email = EmailFormz.dirty(state.email.value);

    if (!state.isValid) {
      emit(state.copyWith(email: email));

      return;
    }

    emit(state.copyWith(submitStatus: LoadStatus.loading));

    try {
      await _repository.forgotPassword(email.value);

      emit(state.copyWith(submitStatus: LoadStatus.success));
    } on ForgotPasswordApiFailure catch (error, stackTrace) {
      final exception = error.error;
      final errorMessage = exception.entity?.message;

      emit(
        state.copyWith(
          errorMesage: errorMessage,
          submitStatus: LoadStatus.error,
        ),
      );

      addError(error, stackTrace);
    } catch (error, stackTrace) {
      emit(state.copyWith(submitStatus: LoadStatus.error));

      addError(error, stackTrace);
    }
  }
}
