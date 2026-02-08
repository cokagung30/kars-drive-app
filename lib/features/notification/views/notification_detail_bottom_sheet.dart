import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

void showNotificationDetailBottomSheet(
  BuildContext context,
  NotificationMessage notification,
) {
  return showAppBottomSheet(
    context,
    child: _NotificationDetailView(notification),
  );
}

class _NotificationDetailView extends StatelessWidget {
  const _NotificationDetailView(this.notification);

  final NotificationMessage notification;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return AppDynamicBottomSheet(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 16,
            bottom: 24,
            top: 12,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detail Notifikasi',
                      style: textTheme.headlineLarge?.copyWith(
                        color: ColorName.darkJungleBlue,
                      ),
                    ),
                    Text(
                      Jiffy.parse(
                        notification.createdAt.toLocal().toIso8601String(),
                      ).format(pattern: 'dd MMMM yyyy, hh:mm'),
                      style: textTheme.labelSmall?.copyWith(
                        color: ColorName.colorOndeliver,
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                color: Colors.white,
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  splashColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      Assets.icons.icClose.path,
                      width: 24,
                      height: 24,
                    ),
                  ),
                  onTap: () => context.pop(),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Judul',
                    style: textTheme.labelSmall?.copyWith(
                      color: ColorName.romanSilver,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.title,
                    style: textTheme.labelSmall?.copyWith(
                      color: ColorName.darkJungleBlue,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
              const CustomDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pesan',
                    style: textTheme.labelSmall?.copyWith(
                      color: ColorName.romanSilver,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.message,
                    style: textTheme.labelSmall?.copyWith(
                      color: ColorName.darkJungleBlue,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
