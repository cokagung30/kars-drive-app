import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';

import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class HistoryItemCard extends StatelessWidget {
  const HistoryItemCard({required this.order, this.onTap, super.key});

  final GestureTapCallback? onTap;

  final Order order;

  String get orderDate {
    return Jiffy.parse(order.orderDate.toIso8601String(), isUtc: true).format(
      pattern: 'dd MMMM yyyy, HH:mm',
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Material(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorName.atenoBlue, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                orderDate,
                                style: textTheme.labelSmall,
                              ),
                            ),
                            AppBadge(
                              color: order.orderStatusColor,
                              label: order.statusName,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          spacing: 14,
                          children: [
                            SvgPicture.asset(
                              Assets.icons.icMapOutlined.path,
                              height: 24,
                              colorFilter: const ColorFilter.mode(
                                ColorName.greenSalem,
                                BlendMode.srcIn,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                order.pickUpLocation,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: textTheme.labelLarge,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                child: Column(
                  children: List.generate(3, (index) {
                    final isLastIndex = index == 2;
                    final marginBottom = isLastIndex ? 0 : 4;

                    return _BulletItem(marginBottom: marginBottom.toDouble());
                  }),
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.icons.icLocationOutlined.path,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      ColorName.candyRed,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${order.dropLocation} askdmaskkmasmdasdas,d,as',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Divider(
                  color: ColorName.romanSilver,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          Assets.icons.icUserOutlined.path,
                          height: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${order.guestFirstName} ${order.guestLastName}',
                            style: textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          Assets.icons.icCurrencyOutlined.path,
                          height: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Rp${order.amount.formatCurrency}',
                          style: textTheme.bodyLarge?.copyWith(
                            color: ColorName.greenSalem,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  const _BulletItem({this.marginBottom = 4});

  final double marginBottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: 4,
      margin: EdgeInsets.only(bottom: marginBottom),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: ColorName.goldenPoppy,
      ),
    );
  }
}
