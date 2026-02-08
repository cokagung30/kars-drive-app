import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/repositories/repositories.dart';
import 'package:kars_driver_app/injection/injection.dart';

part 'withdrawls_event.dart';
part 'withdrawls_state.dart';

class WithdrawlsBloc extends Bloc<WithdrawlsEvent, WithdrawlsState> {
  WithdrawlsBloc({WithdrawRepository? repository})
    : _repository = repository ?? inject(),
      super(const WithdrawlsState()) {
    on<WithdrawHistoryFetched>(_onWithdrawHistoryFetched);
  }

  final WithdrawRepository _repository;

  Future<void> _onWithdrawHistoryFetched(
    WithdrawHistoryFetched _,
    Emitter<WithdrawlsState> emit,
  ) async {
    emit(state.copyWith(status: LoadStatus.loading));

    try {
      final withdrawls = await _repository.getHistories();

      emit(state.copyWith(status: LoadStatus.success, withdrawls: withdrawls));
    } on FetchWithdrawHistoryApiFailure catch (error, stackTrace) {
      emit(state.copyWith(status: LoadStatus.error));

      addError(error, stackTrace);
    } catch (error, stackTrace) {
      emit(state.copyWith(status: LoadStatus.error));

      addError(error, stackTrace);
    }
  }
}
