import 'package:equatable/equatable.dart';
import 'package:kars_driver_app/core/models/models.dart';

class NotificationMessage extends Equatable {
  const NotificationMessage({
    required this.id,
    required this.title,
    required this.message,
    required this.isRead,
    required this.type,
    required this.createdAt,
    this.payload,
  });

  factory NotificationMessage.fromJson(Map<String, dynamic> json) {
    return NotificationMessage(
      id: json['id'] as num,
      title: json['title'] as String,
      message: json['message'] as String,
      isRead: json['is_read'] as bool,
      type: json['type'] as String,
      createdAt: json.containsKey('created_at')
          ? (json['created_at'] != null
                ? DateTime.parse(json['created_at'] as String)
                : DateTime.now())
          : DateTime.now(),
      payload: json.containsKey('payload')
          ? (json['payload'] != null
                ? NotificationPayload.fromJson(
                    json['payload'] as Map<String, dynamic>,
                  )
                : null)
          : null,
    );
  }

  final num id;

  final String title;

  final String message;

  final String type;

  final DateTime createdAt;

  final NotificationPayload? payload;

  final bool isRead;

  NotificationMessage copyWith({bool? isRead}) {
    return NotificationMessage(
      id: id,
      title: title,
      message: message,
      type: type,
      payload: payload,
      createdAt: createdAt,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    message,
    type,
    createdAt,
    payload,
    isRead,
  ];
}
