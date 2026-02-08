part of 'detail_order_bloc.dart';

abstract class DetailOrderEvent extends Equatable {
  const DetailOrderEvent();

  @override
  List<Object?> get props => [];
}

class DetailOrderFetched extends DetailOrderEvent {
  const DetailOrderFetched(this.orderId);

  final String orderId;

  @override
  List<Object?> get props => [orderId];
}

class PickSubmitted extends DetailOrderEvent {
  const PickSubmitted(this.id, this.note);

  final String id;

  final String? note;

  @override
  List<Object?> get props => [];
}
