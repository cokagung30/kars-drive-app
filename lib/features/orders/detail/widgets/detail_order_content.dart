import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/orders/detail/detail_order.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailOrderContent extends StatelessWidget {
  const DetailOrderContent({
    required this.isViewed,
    required this.orderId,
    required this.order,
    super.key,
  });

  final String orderId;

  final bool isViewed;

  final Order order;

  String get orderDate {
    return Jiffy.parse(
      order.orderDate.toIso8601String(),
      isUtc: true,
    ).format(
      pattern: 'dd MMMM yyyy, HH:mm',
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Column(
      children: [
        ConditionWidget(
          isFirstCondition: !isViewed,
          firstChild: const SizedBox.shrink(),
          secondChild: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            color: order.orderStatusColor.withValues(alpha: 0.5),
            child: Text(
              order.statusName,
              style: textTheme.labelLarge?.copyWith(
                color: ColorName.darkJungleBlue,
              ),
            ),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<DetailOrderBloc>().add(DetailOrderFetched(orderId));
            },
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              Assets.icons.icCalendarOutlined.path,
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 6),
                            Text('Tgl. Pesanan', style: textTheme.labelSmall),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '$orderDate WITA',
                          style: textTheme.labelLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _SectionCard(
                  title: 'Pemesan',
                  icon: Assets.icons.icUserOutlined.path,
                  child: Column(
                    children: [
                      _CardItem(
                        title: 'Nama',
                        value: '${order.guestFirstName} ${order.guestLastName}',
                      ),
                      _CardItem(
                        title: 'Nomor Telepon/WA',
                        value: order.guestPhoneNumber,
                      ),
                      _CardItem(
                        title: 'Email',
                        value: order.guestEmail ?? '-',
                      ),
                      _CardItem(
                        title: 'Nomor Penerbangan',
                        value: order.flightNumber,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _SectionCard(
                  title: 'Pengantaran',
                  icon: Assets.icons.icCarInfoOutlined.path,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            if (order.pickupCoordinate != null) {
                              _openGoogleMapDirection(order.pickupCoordinate!);
                            }
                          },
                          splashColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2,
                              vertical: 4,
                            ),
                            child: Row(
                              spacing: 12,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  Assets.icons.icMapOutlined.path,
                                  width: 24,
                                  height: 24,
                                  colorFilter: const ColorFilter.mode(
                                    ColorName.greenSalem,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: ColorName.atenoBlue,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          order.pickUpLocation,
                                          style: textTheme.bodyMedium?.copyWith(
                                            fontSize: 12,
                                            height: 1.4,
                                            color: ColorName.atenoBlue,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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

                            return _BulletItem(
                              marginBottom: marginBottom.toDouble(),
                            );
                          }),
                        ),
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            if (order.pickupCoordinate != null) {
                              _openGoogleMapDirection(order.dropoffCoordinate!);
                            }
                          },
                          splashColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2,
                              vertical: 4,
                            ),
                            child: Row(
                              spacing: 12,
                              children: [
                                SvgPicture.asset(
                                  Assets.icons.icLocationOutlined.path,
                                  width: 24,
                                  height: 24,
                                  colorFilter: const ColorFilter.mode(
                                    ColorName.candyRed,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: ColorName.atenoBlue,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          order.dropLocation,
                                          style: textTheme.bodyMedium?.copyWith(
                                            fontSize: 12,
                                            height: 1.4,
                                            color: ColorName.atenoBlue,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Divider(color: ColorName.romanSilver),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              spacing: 4,
                              children: [
                                SvgPicture.asset(
                                  Assets.icons.icClockOutlined.path,
                                  width: 16,
                                  height: 16,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.black,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                Text(
                                  '${order.duration} (${order.distance.ceil()}km)',
                                  style: textTheme.labelSmall?.copyWith(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (order.car == null) return;

                                showCarDetailBottomSheet(context, order.car!);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                spacing: 4,
                                children: [
                                  SvgPicture.asset(
                                    Assets.icons.icCarTypeOutlined.path,
                                    width: 16,
                                    height: 16,
                                    colorFilter: const ColorFilter.mode(
                                      Colors.black,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: ColorName.atenoBlue,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      order.car?.name ?? '',
                                      style: textTheme.labelLarge?.copyWith(
                                        color: ColorName.atenoBlue,
                                        decoration: TextDecoration.none,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _SectionCard(
                  title: 'Penumpang',
                  icon: Assets.icons.icUserGroupOutlined.path,
                  child: Column(
                    children: [
                      _CardItem(
                        title: 'Dewasa',
                        value: order.guestAdultCount == 0
                            ? 'Tidak Ada'
                            : '${order.guestAdultCount} Orang',
                      ),
                      _CardItem(
                        title: 'Anak - anak',
                        value: order.guestBabyCount == 0
                            ? 'Tidak Ada'
                            : '${order.guestBabyCount} Orang',
                      ),
                      _CardItem(
                        title: 'Hewan Peliharaan',
                        value: order.guestPetCount == 0
                            ? 'Tidak Ada'
                            : '${order.guestPetCount} Orang',
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Barang Bawaan',
                              style: textTheme.labelSmall,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => showLuggageDetailBottomSheet(
                              context,
                              order.guestLuggage,
                            ),
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: ColorName.atenoBlue,
                                  ),
                                ),
                              ),
                              child: Text(
                                order.guestLuggage.isEmpty
                                    ? 'Tidak Ada'
                                    : '${order.guestLuggage.length} Buah',
                                style: textTheme.labelLarge?.copyWith(
                                  color: ColorName.atenoBlue,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                ConditionWidget(
                  isFirstCondition: order.pickUpNote == null,
                  firstChild: Column(
                    children: [
                      _SectionCard(
                        title: 'Catatan Penjemputan',
                        icon: Assets.icons.icNoteOutlined.path,
                        child: Text(
                          order.pickUpLocation,
                          style: textTheme.labelSmall,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                  secondChild: const SizedBox.shrink(),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: ColorName.atenoBlue, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    spacing: 8,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Harga Pengantaran',
                            style: textTheme.labelSmall,
                          ),
                          Text(
                            'Rp ${order.amount.formatCurrency}',
                            style: textTheme.labelMedium?.copyWith(
                              color: ColorName.atenoBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Biaya Admin', style: textTheme.labelSmall),
                          Text(
                            '- Rp ${order.platformIncome.formatCurrency}',
                            style: textTheme.labelMedium?.copyWith(
                              color: ColorName.candyRed,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Pendapatan', style: textTheme.labelSmall),
                          Text(
                            'Rp ${order.estimationIncome.formatCurrency}',
                            style: textTheme.labelMedium?.copyWith(
                              color: ColorName.greenSalem,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                ActionButton(order),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _openGoogleMapDirection(Coordinate coordinate) async {
    final uri = Uri.parse(
      'google.navigation:q=${coordinate.latitude},${coordinate.longitude}'
      '&mode=d',
    );

    try {
      if (await canLaunchUrl(uri)) {
        final ok = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        if (!ok) {
          await launchUrl(uri);
        }
      } else {
        await launchUrl(uri);
      }
    } catch (e) {
      debugPrint('launchUrl error: $e');
    }
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;

  final String icon;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ColorName.atenoBlue, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                icon,
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  ColorName.atenoBlue,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                title,
                style: textTheme.bodyLarge?.copyWith(
                  color: ColorName.atenoBlue,
                ),
              ),
            ],
          ),
          const Divider(color: ColorName.romanSilver),
          child,
        ],
      ),
    );
  }
}

class _CardItem extends StatelessWidget {
  const _CardItem({
    required this.title,
    this.value,
  });

  final String title;

  final String? value;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(title, style: textTheme.labelSmall),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(value ?? '-', style: textTheme.labelSmall),
            ),
          ),
        ],
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
