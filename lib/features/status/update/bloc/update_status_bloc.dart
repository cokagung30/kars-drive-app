import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/repositories/repositories.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/injection/injection.dart';

part 'update_status_event.dart';
part 'update_status_state.dart';

class UpdateStatusBloc extends Bloc<UpdateStatusEvent, UpdateStatusState> {
  UpdateStatusBloc({
    required bool currentStatus,
    ProfileRepository? repository,
  }) : _repository = repository ?? inject(),
       _currentStatus = currentStatus,
       super(UpdateStatusState()) {
    on<ReasonChanged>(_onReasonChanged);
    on<ReasonFocused>(_onReasonFocused);
    on<FormSubmitted>(_onFormSubmitted);
  }

  final bool _currentStatus;

  final ProfileRepository _repository;

  void _onReasonChanged(ReasonChanged event, Emitter<UpdateStatusState> emit) {
    emit(state.copyWith(reason: ReasonFormz.pure(event.reason)));
  }

  void _onReasonFocused(ReasonFocused event, Emitter<UpdateStatusState> emit) {
    emit(state.copyWith(hasReasonFocus: event.isFocused));
  }

  Future<void> _onFormSubmitted(
    FormSubmitted _,
    Emitter<UpdateStatusState> emit,
  ) async {
    final reason = ReasonFormz.dirty(state.reason.value);

    if (!state.isValid) {
      emit(state.copyWith(reason: reason));

      return;
    }

    emit(state.copyWith(submitStatus: LoadStatus.loading));

    try {
      await _repository.updateStatus(reason.value, _currentStatus ? 0 : 1);
      emit(state.copyWith(submitStatus: LoadStatus.success));
    } catch (error, stackTrace) {
      emit(state.copyWith(submitStatus: LoadStatus.error));

      addError(error, stackTrace);
    }
  }
}
