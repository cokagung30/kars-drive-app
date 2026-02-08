import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/repositories/repositories.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/injection/injection.dart';

part 'update_account_event.dart';
part 'update_account_state.dart';

class UpdateAccountBloc extends Bloc<UpdateAccountEvent, UpdateAccountState> {
  UpdateAccountBloc({required bool userStatus, ProfileRepository? repository})
    : _repository = repository ?? inject(),
      _userStatus = userStatus,
      super(const UpdateAccountState()) {
    on<ProfileFetched>(_onProfileFetched);
    on<NameChanged>(_onNameChanged);
    on<NameFocused>(_onNameFocused);
    on<EmailChanged>(_onEmailChanged);
    on<EmailFocused>(_onEmailFocused);
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<PhoneNumberFocused>(_onPhoneNumberFocused);
    on<AvatarChanged>(_onAvatarChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  final ProfileRepository _repository;

  final bool _userStatus;

  Future<void> _onProfileFetched(
    ProfileFetched _,
    Emitter<UpdateAccountState> emit,
  ) async {
    emit(state.copyWith(fetchStatus: LoadStatus.loading));

    try {
      final profile = await _repository.getProfile();

      if (profile != null) {
        final name = NameFormz.pure(profile.name);
        final email = EmailFormz.pure(profile.email);
        final phoneNumber = PhoneNumberFormz.pure(profile.phone ?? '');

        emit(
          state.copyWith(name: name, email: email, phoneNumber: phoneNumber),
        );
      }

      emit(state.copyWith(profile: profile, fetchStatus: LoadStatus.success));
    } on GetProfileApiFailure catch (error, stackTrace) {
      emit(state.copyWith(fetchStatus: LoadStatus.error));
      addError(error, stackTrace);
    } catch (error, stackTrace) {
      emit(state.copyWith(fetchStatus: LoadStatus.error));

      addError(error, stackTrace);
    }
  }

  void _onNameChanged(NameChanged event, Emitter<UpdateAccountState> emit) {
    emit(state.copyWith(name: NameFormz.pure(event.name)));
  }

  void _onNameFocused(NameFocused event, Emitter<UpdateAccountState> emit) {
    emit(state.copyWith(hasNameFocus: event.isFocus));
  }

  void _onEmailChanged(EmailChanged event, Emitter<UpdateAccountState> emit) {
    emit(state.copyWith(email: EmailFormz.pure(event.email)));
  }

  void _onEmailFocused(EmailFocused event, Emitter<UpdateAccountState> emit) {
    emit(state.copyWith(hasEmailFocus: event.isFocus));
  }

  void _onPhoneNumberChanged(
    PhoneNumberChanged event,
    Emitter<UpdateAccountState> emit,
  ) {
    emit(state.copyWith(phoneNumber: PhoneNumberFormz.pure(event.phoneNumber)));
  }

  void _onPhoneNumberFocused(
    PhoneNumberFocused event,
    Emitter<UpdateAccountState> emit,
  ) {
    emit(state.copyWith(hasPhoneNumberFocus: event.isFocus));
  }

  void _onAvatarChanged(AvatarChanged event, Emitter<UpdateAccountState> emit) {
    emit(state.copyWith(avatar: event.avatar));
  }

  Future<void> _onFormSubmitted(
    FormSubmitted _,
    Emitter<UpdateAccountState> emit,
  ) async {
    final name = NameFormz.dirty(state.name.value);
    final email = EmailFormz.dirty(state.email.value);
    final phoneNumber = PhoneNumberFormz.dirty(state.phoneNumber.value);

    if (!state.isValid) {
      emit(state.copyWith(name: name, email: email, phoneNumber: phoneNumber));

      return;
    }

    emit(state.copyWith(submitStatus: LoadStatus.loading));

    try {
      final request = UpdateProfileRequest(
        name: name.value,
        email: email.value,
        phoneNumber: phoneNumber.value,
        avatar: state.avatar.isNotEmpty ? File(state.avatar) : null,
      );

      await _repository.updateProfile(request, lastStatusUser: _userStatus);

      emit(state.copyWith(submitStatus: LoadStatus.success));
    } on UpdateProfileApiFailure catch (error, stackTrace) {
      emit(state.copyWith(submitStatus: LoadStatus.error));
      addError(error, stackTrace);
    } catch (error, stackTrace) {
      emit(state.copyWith(submitStatus: LoadStatus.error));
      addError(error, stackTrace);
    }
  }
}
