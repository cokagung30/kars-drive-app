import 'package:equatable/equatable.dart';

class DetailOrderExtra extends Equatable {
  const DetailOrderExtra({
    required this.orderId,
    this.isView = false,
  });

  final String orderId;

  final bool isView;

  @override
  List<Object?> get props => [orderId, isView];
}
