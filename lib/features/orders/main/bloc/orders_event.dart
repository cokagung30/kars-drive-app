part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object?> get props => [];
}

class SearchChanged extends OrdersEvent {
  const SearchChanged(this.query);

  final String? query;

  @override
  List<Object?> get props => [query];
}

class OrdersFetched extends OrdersEvent {
  const OrdersFetched();
}

class OrderPickSubmitted extends OrdersEvent {
  const OrderPickSubmitted(this.id, this.note);

  final String id;

  final String? note;

  @override
  List<Object?> get props => [];
}
