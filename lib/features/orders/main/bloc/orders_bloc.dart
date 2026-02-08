import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_bus/event_bus.dart';
import 'package:kars_driver_app/core/api/api.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/repositories/repositories.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/event/event.dart';
import 'package:kars_driver_app/injection/injection.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc({OrderRepository? orderRepository})
    : _orderRepository = orderRepository ?? inject(),
      _eventBus = inject(),
      super(const OrdersState()) {
    on<SearchChanged>(_onSearchChanged, transformer: debounce());
    on<OrdersFetched>(_onOrdersFetched);
    on<OrderPickSubmitted>(_onOrderPickSubmitted);
  }

  final OrderRepository _orderRepository;

  final EventBus _eventBus;

  Future<void> _onSearchChanged(
    SearchChanged event,
    Emitter<OrdersState> emit,
  ) async {
    final query = event.query?.trim();

    emit(state.copyWith(query: query));

    add(const OrdersFetched());
  }

  Future<void> _onOrdersFetched(
    OrdersFetched _,
    Emitter<OrdersState> emit,
  ) async {
    final query = state.query;

    emit(state.copyWith(status: LoadStatus.loading));

    try {
      final orders = await _orderRepository.fetchOrders(query);

      emit(state.copyWith(orders: orders, status: LoadStatus.success));
    } on FetchOrderOpenApiFailure catch (error, stackTrace) {
      emit(state.copyWith(status: LoadStatus.error));

      addError(error, stackTrace);
    } catch (error, stackTrace) {
      emit(state.copyWith(status: LoadStatus.error));

      addError(error, stackTrace);
    }
  }

  Future<void> _onOrderPickSubmitted(
    OrderPickSubmitted event,
    Emitter<OrdersState> emit,
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
