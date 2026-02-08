import 'package:equatable/equatable.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/repositories/repositories.dart';
import 'package:kars_driver_app/event/event.dart';
import 'package:kars_driver_app/injection/injection.dart';

part 'detail_order_event.dart';
part 'detail_order_state.dart';

class DetailOrderBloc extends Bloc<DetailOrderEvent, DetailOrderState> {
  DetailOrderBloc({
    OrderRepository? orderRepository,
  }) : _orderRepository = orderRepository ?? inject(),
       _eventBus = inject(),
       super(const DetailOrderState()) {
    on<DetailOrderFetched>(_onDetailOrderFetched);
    on<PickSubmitted>(_onPickSubmitted);
  }

  final OrderRepository _orderRepository;

  final EventBus _eventBus;

  Future<void> _onDetailOrderFetched(
    DetailOrderFetched event,
    Emitter<DetailOrderState> emit,
  ) async {
    emit(state.copyWith(status: LoadStatus.loading));

    try {
      final order = await _orderRepository.getDetail(event.orderId);

      emit(state.copyWith(order: order, status: LoadStatus.success));
    } on GetDetailOrderApiFailure catch (error, stackTrace) {
      emit(state.copyWith(status: LoadStatus.error));

      addError(error, stackTrace);
    } catch (error, stackTrace) {
      emit(state.copyWith(status: LoadStatus.error));

      addError(error, stackTrace);
    }
  }

  Future<void> _onPickSubmitted(
    PickSubmitted event,
    Emitter<DetailOrderState> emit,
  ) async {
    emit(state.copyWith(pickOrderStatus: LoadStatus.loading));

    try {
      await _orderRepository.pickOrder(event.id, event.note);

      emit(state.copyWith(pickOrderStatus: LoadStatus.success));

      _eventBus.fire(const UpdateOrderEvent());
    } catch (error, stackTrace) {
      emit(state.copyWith(pickOrderStatus: LoadStatus.error));

      addError(error, stackTrace);
    }
  }
}
