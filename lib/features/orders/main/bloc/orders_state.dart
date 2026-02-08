part of 'orders_bloc.dart';

class OrdersState extends Equatable {
  const OrdersState({
    this.query,
    this.status = LoadStatus.initial,
    this.pickOrderStatus = LoadStatus.initial,
    this.orders = const [],
  });

  final LoadStatus status;

  final LoadStatus pickOrderStatus;

  final List<Order> orders;

  final String? query;

  OrdersState copyWith({
    LoadStatus? status,
    LoadStatus? pickOrderStatus,
    List<Order>? orders,
    String? query,
  }) {
    return OrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      query: query ?? this.query,
      pickOrderStatus: pickOrderStatus ?? this.pickOrderStatus,
    );
  }

  @override
  List<Object?> get props => [status, orders, query, pickOrderStatus];
}
