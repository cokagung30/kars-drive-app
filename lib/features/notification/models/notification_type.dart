import 'package:kars_driver_app/gen/assets.gen.dart';

enum NotificationType {
  personal('PERSONAL'),
  broadcast('BROADCAST'),
  booking('BOOKING'),
  withdraw('WD');

  const NotificationType(this.id);

  final String id;
}

extension NotificationTypeX on String {
  String get iconPath {
    if (this == NotificationType.broadcast.id) {
      return Assets.icons.icBroadcastNotification.path;
    }

    if (this == NotificationType.booking.id) {
      return Assets.icons.icBookingNotification.path;
    }

    if (this == NotificationType.withdraw.id) {
      return Assets.icons.icWithdrawNotification.path;
    }

    return Assets.icons.icPersonalNotification.path;
  }

  bool get isBookingType {
    return this == NotificationType.booking.id;
  }
}
