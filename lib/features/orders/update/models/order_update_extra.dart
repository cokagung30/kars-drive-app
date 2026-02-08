import 'package:equatable/equatable.dart';

class OrderUpdateExtra extends Equatable {
  const OrderUpdateExtra({
    required this.orderId,
    required this.status,
  });

  final String orderId;

  final String status;

  @override
  List<Object?> get props => [orderId, status];
}
