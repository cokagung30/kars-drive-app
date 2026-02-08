import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/repositories/repositories.dart';
import 'package:kars_driver_app/injection/injection.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({
    DashboardRepository? repository,
  }) : _repository = repository ?? inject(),
       super(const DashboardState()) {
    on<ShowEarningBalanceChanged>(_onShowEarningBalanceChanged);
    on<SummaryFetched>(_onSummaryFetched);
  }

  final DashboardRepository _repository;

  void _onShowEarningBalanceChanged(
    ShowEarningBalanceChanged event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(showEarningBalance: !state.showEarningBalance));
  }

  Future<void> _onSummaryFetched(
    SummaryFetched _,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(status: LoadStatus.loading));

    try {
      final summary = await _repository.getSummary();

      emit(state.copyWith(summary: summary, status: LoadStatus.success));
    } on FetchSummaryApiFailure catch (error, stackTrace) {
      emit(state.copyWith(status: LoadStatus.error));

      addError(error, stackTrace);
    } catch (error, stackTrace) {
      emit(state.copyWith(status: LoadStatus.error));

      addError(error, stackTrace);
    }
  }
}
