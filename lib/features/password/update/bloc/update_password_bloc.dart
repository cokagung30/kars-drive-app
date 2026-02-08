import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:kars_driver_app/core/api/profile/profile.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/repositories/repositories.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/injection/injection.dart';

part 'update_password_event.dart';
part 'update_password_state.dart';

class UpdatePasswordBloc
    extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
  UpdatePasswordBloc({
    ProfileRepository? repository,
  }) : _repository = repository ?? inject(),
       super(const UpdatePasswordState()) {
    on<PasswordChanged>(_onPasswordChanged);
    on<PasswordFocused>(_onPasswordFocused);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<ConfirmPasswordFocused>(_onConfirmPasswordFocused);
    on<FormSubmitted>(_onFormSubmitted);
  }

  final ProfileRepository _repository;

  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<UpdatePasswordState> emit,
  ) {
    emit(
      state.copyWith(newPassword: PasswordFormz.pure(value: event.password)),
    );
  }

  void _onConfirmPasswordChanged(
    ConfirmPasswordChanged event,
    Emitter<UpdatePasswordState> emit,
  ) {
    emit(
      state.copyWith(
        confirmPassword: ConfirmPasswordFormz.pure(value: event.password),
      ),
    );
  }

  void _onPasswordFocused(
    PasswordFocused event,
    Emitter<UpdatePasswordState> emit,
  ) {
    emit(state.copyWith(hasNewPasswordFocus: event.isFocused));
  }

  void _onConfirmPasswordFocused(
    ConfirmPasswordFocused event,
    Emitter<UpdatePasswordState> emit,
  ) {
    emit(state.copyWith(hasConfirmPasswordFocus: event.isFocused));
  }

  Future<void> _onFormSubmitted(
    FormSubmitted _,
    Emitter<UpdatePasswordState> emit,
  ) async {
    final newPassword = PasswordFormz.dirty(
      value: state.newPassword.value,
      minLength: 6,
    );
    final confirmPassword = ConfirmPasswordFormz.dirty(
      password: newPassword.value,
      value: state.confirmPassword.value,
    );

    if (!state.isValid) {
      emit(
        state.copyWith(
          newPassword: newPassword,
          confirmPassword: confirmPassword,
        ),
      );

      return;
    }

    emit(state.copyWith(submitStatus: LoadStatus.loading));

    try {
      await _repository.updatePassword(
        newPassword.value,
        confirmPassword.value,
      );
      emit(state.copyWith(submitStatus: LoadStatus.success));
    } on UpdatePasswordApiFailure catch (error, stackTrace) {
      emit(state.copyWith(submitStatus: LoadStatus.error));

      addError(error, stackTrace);
    } catch (error, stackTrace) {
      emit(state.copyWith(submitStatus: LoadStatus.error));

      addError(error, stackTrace);
    }
  }
}
