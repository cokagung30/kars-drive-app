import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/orders/bid/bid_order.dart';
import 'package:kars_driver_app/features/orders/detail/detail_order.dart';

class BidButton extends StatelessWidget {
  const BidButton(this.orderId, {super.key});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: AppButton.elevated(
        label: 'Ambil Pesanan',
        textStyle: textTheme.bodyLarge,
        onTap: () => showBidOrderBottomSheet(context, (value) {
          context
            ..pop()
            ..read<DetailOrderBloc>().add(PickSubmitted(orderId, value));
        }),
      ),
    );
  }
}
