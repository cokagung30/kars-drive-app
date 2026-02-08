import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/notification/notification.dart';
import 'package:kars_driver_app/features/orders/detail/detail_order.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem(this.notification, {super.key});

  final NotificationMessage notification;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return InkWell(
      onTap: () {
        if (notification.type.isBookingType && notification.payload != null) {
          context.pushNamed(
            'order-detail',
            extra: DetailOrderExtra(
              orderId: notification.payload!.orderId,
              isView: true,
            ),
          );
        } else {
          showNotificationDetailBottomSheet(context, notification);
        }

        if (!notification.isRead) {
          context.read<NotificationBloc>().add(
            NotificationUpdated(notification.id),
          );
        }
      },
      splashColor: Colors.transparent,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              spacing: 12,
              children: [
                SvgPicture.asset(
                  notification.type.iconPath,
                  width: 42,
                  height: 42,
                ),
                Expanded(
                  child: Column(
                    spacing: 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 8,
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: notification.isRead
                                  ? textTheme.headlineMedium
                                  : textTheme.headlineLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            Jiffy.parse(
                              notification.createdAt
                                  .toLocal()
                                  .toIso8601String(),
                            ).format(pattern: 'dd MMM'),
                            style: notification.isRead
                                ? textTheme.labelSmall
                                : textTheme.labelLarge,
                          ),
                        ],
                      ),
                      Row(
                        spacing: 8,
                        children: [
                          Expanded(
                            child: Text(
                              notification.message,
                              style: textTheme.bodySmall?.copyWith(
                                color: ColorName.romanSilver,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          ConditionWidget(
                            isFirstCondition: notification.isRead,
                            firstChild: const SizedBox.shrink(),
                            secondChild: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorName.candyRed.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const CustomDivider(color: ColorName.quickSilver),
        ],
      ),
    );
  }
}
