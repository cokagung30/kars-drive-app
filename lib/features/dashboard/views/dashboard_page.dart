import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/event/event.dart';
import 'package:kars_driver_app/features/dashboard/dashboard.dart';
import 'package:kars_driver_app/features/orders/detail/detail_order.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';
import 'package:kars_driver_app/injection/injection.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = DashboardBloc();

        bloc.add(const SummaryFetched());

        return bloc;
      },
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatefulWidget {
  const _DashboardView();

  @override
  State<_DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<_DashboardView> {
  StreamSubscription<UpdateOrderEvent>? _updateOrderSubscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final updateOrderStreamEvent = inject<EventBus>().on<UpdateOrderEvent>();

    _updateOrderSubscription ??= updateOrderStreamEvent.listen((event) {
      if (mounted) {
        context.read<DashboardBloc>().add(const SummaryFetched());
      }
    });
  }

  @override
  void dispose() {
    _updateOrderSubscription?.cancel();
    _updateOrderSubscription = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Scaffold(
      backgroundColor: ColorName.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<DashboardBloc, DashboardState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            final histories = state.summary != null
                ? (state.summary?.history ?? [])
                : <Order>[];

            return RefreshIndicator(
              backgroundColor: Colors.white,
              onRefresh: () async {
                context.read<DashboardBloc>().add(const SummaryFetched());
              },
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          'Pendapatan Anda Saat Ini',
                          style: textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 16),
                        EarningOverviewCard(
                          isLoading: state.status.isLoading,
                          summary: state.summary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Pengajuan Anda',
                          style: textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  ConditionWidget(
                    isFirstCondition: state.status.isLoading,
                    firstChild: const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: ColorName.atenoBlue,
                        ),
                      ),
                    ),
                    secondChild: ConditionWidget(
                      isFirstCondition: histories.isEmpty,
                      firstChild: SliverFillRemaining(
                        child: Center(
                          child: EmptyView(
                            onRefresh: () {
                              const event = SummaryFetched();

                              context.read<DashboardBloc>().add(event);
                            },
                          ),
                        ),
                      ),
                      secondChild: SliverToBoxAdapter(
                        child: Column(
                          spacing: 16,
                          children: [
                            ...histories.map((order) {
                              return HistoryItemCard(
                                order: order,
                                onTap: () => context.pushNamed(
                                  'order-detail',
                                  extra: DetailOrderExtra(
                                    orderId: order.id,
                                    isView: true,
                                  ),
                                ),
                              );
                            }),
                            const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
