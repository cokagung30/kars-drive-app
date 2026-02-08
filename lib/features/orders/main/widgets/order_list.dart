import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/orders/bid/bid_order.dart';
import 'package:kars_driver_app/features/orders/detail/detail_order.dart';
import 'package:kars_driver_app/features/orders/main/orders.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: ColorName.atenoBlue),
          );
        }

        final orders = state.orders;

        if (orders.isEmpty) {
          return EmptyView(onRefresh: () => _onRefresh(context));
        }

        return RefreshIndicator(
          onRefresh: () => _onRefresh(context),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: List.generate(orders.length, (index) {
                final isFirst = index == 0;

                return _OrderItem(isFirst: isFirst, order: orders[index]);
              }),
            ),
          ),
        );
      },
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<OrdersBloc>().add(const OrdersFetched());
  }
}

class _OrderItem extends StatelessWidget {
  const _OrderItem({required this.isFirst, required this.order});

  final bool isFirst;

  final Order order;

  String get orderDate {
    return Jiffy.parse(
      order.orderDate.toIso8601String(),
      isUtc: true,
    ).format(
      pattern: 'dd MMMM yyyy, HH:mm',
    );
  }

  num get passengerCount {
    return order.guestAdultCount + order.guestBabyCount;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Container(
      padding: const EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 16, top: isFirst ? 8 : 0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: ColorName.atenoBlue, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            orderDate,
            style: textTheme.labelSmall?.copyWith(fontSize: 10),
          ),
          const SizedBox(height: 4),
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
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                '${order.guestFirstName} ${order.guestLastName}',
                          ),
                          const WidgetSpan(child: SizedBox(width: 2)),
                          TextSpan(text: '($passengerCount Orang)'),
                        ],
                        style: textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                child: Text(
                  'Rp${order.amount.formatCurrency}',
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ColorName.greenSalem,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(
            height: 1,
            color: ColorName.romanSilver,
          ),
          const SizedBox(height: 8),
          Text('Pengantaran', style: textTheme.bodyLarge),
          const SizedBox(height: 8),
          Row(
            spacing: 12,
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
                  style: textTheme.labelSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: BulletList(spacing: 4),
          ),
          Row(
            spacing: 12,
            children: [
              SvgPicture.asset(
                Assets.icons.icLocationOutlined.path,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  ColorName.candyRed,
                  BlendMode.srcIn,
                ),
              ),
              Expanded(
                child: Text(
                  order.dropLocation,
                  style: textTheme.labelSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(
            height: 1,
            color: ColorName.romanSilver,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icons.icClockOutlined.path,
                      height: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${order.duration} (${order.distance.ceil()}km)',
                      style: textTheme.labelSmall?.copyWith(fontSize: 10),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      Assets.icons.icCarTypeOutlined.path,
                      height: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      order.car?.name ?? 'Economy',
                      style: textTheme.labelSmall?.copyWith(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: AppButton.outlined(
                  label: 'Lihat Detail',
                  onTap: () => context.pushNamed(
                    'order-detail',
                    extra: DetailOrderExtra(orderId: order.id),
                  ),
                  textStyle: textTheme.labelLarge?.copyWith(
                    color: ColorName.atenoBlue,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: AppButton.elevated(
                  label: 'Konfirmasi Pesanan',
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 8,
                  ),
                  onTap: () => showBidOrderBottomSheet(context, (value) {
                    context.pop();
                    context.read<OrdersBloc>().add(
                      OrderPickSubmitted(order.id, value),
                    );
                  }),
                  textStyle: textTheme.labelLarge?.copyWith(
                    color: ColorName.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
