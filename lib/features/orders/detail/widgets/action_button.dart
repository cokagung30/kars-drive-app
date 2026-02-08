import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/orders/bid/views/views.dart';
import 'package:kars_driver_app/features/orders/detail/detail_order.dart';
import 'package:kars_driver_app/features/orders/update/order_update.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(this.order, {super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ConditionWidget(
        isFirstCondition: order.hasActionButtons,
        firstChild: _Button(order),
        secondChild: const SizedBox.shrink(),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button(this.order);

  final Order order;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return switch (order.status) {
      'PAID_CUSTOMER' => AppButton.elevated(
        label: 'Konfirmasi Pesanan',
        textStyle: textTheme.labelLarge,
        onTap: () {
          showBidOrderBottomSheet(context, (value) {
            if (context.canPop()) {
              context.pop();
            }
            context.read<DetailOrderBloc>().add(PickSubmitted(order.id, value));
          });
        },
      ),
      'CONFIRM_BID' => ConditionWidget(
        isFirstCondition: order.canPickup,
        firstChild: AppButton.elevated(
          label: 'Otw Jemput',
          textStyle: textTheme.labelLarge,
          onTap: () {
            context.pushNamed(
              'order-finish',
              extra: OrderUpdateExtra(
                orderId: order.id,
                status: order.status,
              ),
            );
          },
        ),
        secondChild: const SizedBox.shrink(),
      ),
      'PICKUP' => AppButton.elevated(
        label: 'Jemput',
        textStyle: textTheme.labelLarge,
        onTap: () {
          context.pushNamed(
            'order-finish',
            extra: OrderUpdateExtra(
              orderId: order.id,
              status: order.status,
            ),
          );
        },
      ),
      'ONDELIVER' => AppButton.elevated(
        label: 'Tiba Ditujuan',
        textStyle: textTheme.labelLarge,
        onTap: () {
          context.pushNamed(
            'order-finish',
            extra: OrderUpdateExtra(
              orderId: order.id,
              status: order.status,
            ),
          );
        },
      ),
      _ => const SizedBox.shrink(),
    };
  }
}
