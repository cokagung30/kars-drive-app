part of 'detail_order_bloc.dart';

class DetailOrderState extends Equatable {
  const DetailOrderState({
    this.order,
    this.status = LoadStatus.initial,
    this.pickOrderStatus = LoadStatus.initial,
  });

  final LoadStatus status;

  final LoadStatus pickOrderStatus;

  final Order? order;

  DetailOrderState copyWith({
    LoadStatus? status,
    Order? order,
    LoadStatus? pickOrderStatus,
  }) {
    return DetailOrderState(
      status: status ?? this.status,
      order: order ?? this.order,
      pickOrderStatus: pickOrderStatus ?? this.pickOrderStatus,
    );
  }

  @override
  List<Object?> get props => [status, order, pickOrderStatus];
}
