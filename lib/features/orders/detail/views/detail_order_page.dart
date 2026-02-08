import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/event/event.dart';
import 'package:kars_driver_app/features/orders/detail/detail_order.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';
import 'package:kars_driver_app/injection/injection.dart';

class DetailOrderPage extends StatelessWidget {
  const DetailOrderPage(this.extra, {super.key});

  final DetailOrderExtra extra;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = DetailOrderBloc();

        bloc.add(DetailOrderFetched(extra.orderId));

        return bloc;
      },
      child: _DetailOrderView(isViewed: extra.isView, orderId: extra.orderId),
    );
  }
}

class _DetailOrderView extends StatefulWidget {
  const _DetailOrderView({required this.isViewed, required this.orderId});

  final String orderId;

  final bool isViewed;

  @override
  State<_DetailOrderView> createState() => _DetailOrderViewState();
}

class _DetailOrderViewState extends State<_DetailOrderView> {
  StreamSubscription<UpdateOrderEvent>? _updateOrderEventSubscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final updateOrderStreamEvent = inject<EventBus>().on<UpdateOrderEvent>();

    _updateOrderEventSubscription ??= updateOrderStreamEvent.listen((event) {
      if (mounted) {
        context.read<DetailOrderBloc>().add(DetailOrderFetched(widget.orderId));
      }
    });
  }

  @override
  void dispose() {
    _updateOrderEventSubscription?.cancel();
    _updateOrderEventSubscription = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DetailOrderListener(
      child: Scaffold(
        body: SafeArea(
          child: Scaffold(
            backgroundColor: ColorName.cultured,
            appBar: const CustomAppBar(
              leadingWidth: double.infinity,
              leading: _AppBarLeading(),
            ),
            body: BlocBuilder<DetailOrderBloc, DetailOrderState>(
              buildWhen: (previous, current) {
                return previous.status != current.status;
              },
              builder: (context, state) {
                if (state.status.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ColorName.atenoBlue,
                    ),
                  );
                }

                final order = state.order;

                if (order == null) {
                  return EmptyView(
                    onRefresh: () {
                      context.read<DetailOrderBloc>().add(
                        DetailOrderFetched(widget.orderId),
                      );
                    },
                  );
                }

                return DetailOrderContent(
                  isViewed: widget.isViewed,
                  orderId: widget.orderId,
                  order: order,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBarLeading extends StatelessWidget {
  const _AppBarLeading();

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Row(
      children: [
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () => context.pop(),
          child: SvgPicture.asset(
            Assets.icons.icClose.path,
            width: 22,
            height: 22,
            colorFilter: const ColorFilter.mode(
              ColorName.darkJungleBlue,
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            'Detail Pesanan',
            style: textTheme.headlineLarge,
          ),
        ),
      ],
    );
  }
}
