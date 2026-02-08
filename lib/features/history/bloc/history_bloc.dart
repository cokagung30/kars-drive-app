import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/repositories/repositories.dart';
import 'package:kars_driver_app/injection/injection.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc({
    OrderRepository? orderRepository,
  }) : _orderRepository = orderRepository ?? inject(),
       super(const HistoryState()) {
    on<HistoriesFetched>(_onHistoriesFetched);
  }

  final OrderRepository _orderRepository;

  Future<void> _onHistoriesFetched(
    HistoriesFetched _,
    Emitter<HistoryState> emit,
  ) async {
    emit(state.copyWith(status: LoadStatus.loading));

    try {
      final histories = await _orderRepository.fetchHistories();

      emit(state.copyWith(histories: histories, status: LoadStatus.success));
    } on FetchHistoryOrderApiFailure catch (error, stackTrace) {
      emit(state.copyWith(status: LoadStatus.error));

      addError(error, stackTrace);
    } catch (error, stackTrace) {
      emit(state.copyWith(status: LoadStatus.error));

      addError(error, stackTrace);
    }
  }
}
