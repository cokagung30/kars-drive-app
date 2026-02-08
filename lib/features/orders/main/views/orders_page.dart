import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/event/event.dart';
import 'package:kars_driver_app/features/orders/main/orders.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';
import 'package:kars_driver_app/injection/injection.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersBloc()..add(const OrdersFetched()),
      child: const _OrdersView(),
    );
  }
}

class _OrdersView extends StatefulWidget {
  const _OrdersView();

  @override
  State<_OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<_OrdersView> {
  final _searchController = TextEditingController();

  final _searchFocusNode = FocusNode();

  StreamSubscription<UpdateOrderEvent>? _updateOrderSubscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final updateOrderStreamEvent = inject<EventBus>().on<UpdateOrderEvent>();

    _updateOrderSubscription ??= updateOrderStreamEvent.listen((event) {
      if (mounted) {
        context.read<OrdersBloc>().add(const OrdersFetched());
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _updateOrderSubscription?.cancel();
    _updateOrderSubscription = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return OrderListener(
      child: Scaffold(
        backgroundColor: ColorName.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Daftar Pesanan',
                style: textTheme.headlineLarge?.copyWith(
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              SearchTextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
              ),
              const SizedBox(height: 8),
              const Expanded(child: OrderList()),
            ],
          ),
        ),
      ),
    );
  }
}
