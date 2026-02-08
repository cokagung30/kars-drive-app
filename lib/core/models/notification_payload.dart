import 'package:equatable/equatable.dart';

class NotificationPayload extends Equatable {
  const NotificationPayload({
    required this.orderId,
  });

  factory NotificationPayload.fromJson(Map<String, dynamic> json) {
    return NotificationPayload(orderId: json['order_id'] as String);
  }

  final String orderId;

  @override
  List<Object?> get props => [orderId];
}
