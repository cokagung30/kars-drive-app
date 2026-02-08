import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/history/history.dart';
import 'package:kars_driver_app/features/orders/detail/detail_order.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HistoryBloc()..add(const HistoriesFetched()),
      child: const _HistoryView(),
    );
  }
}

class _HistoryView extends StatefulWidget {
  const _HistoryView();

  @override
  State<_HistoryView> createState() => __HistoryViewState();
}

class __HistoryViewState extends State<_HistoryView> {
  final _searchController = TextEditingController();

  final _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          backgroundColor: ColorName.cultured,
          appBar: CustomAppBar(
            title: 'Riwayat Pengantaran',
            titleStyle: textTheme.headlineLarge,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              children: [
                SearchTextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: BlocBuilder<HistoryBloc, HistoryState>(
                    buildWhen: (p, c) => p.status != c.status,
                    builder: (context, state) {
                      final status = state.status;

                      if (status.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: ColorName.atenoBlue,
                          ),
                        );
                      }

                      final histories = state.histories;

                      if (histories.isEmpty) {
                        return Center(
                          child: EmptyView(
                            onRefresh: () => _onRefresh(context),
                          ),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: () => _onRefresh(context),
                        child: ListView(
                          children: [
                            const SizedBox(height: 16),
                            ...List.generate(histories.length, (index) {
                              final history = histories[index];

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: HistoryItemCard(
                                  order: history,
                                  onTap: () => context.pushNamed(
                                    'order-detail',
                                    extra: DetailOrderExtra(
                                      orderId: history.id,
                                      isView: true,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<HistoryBloc>().add(const HistoriesFetched());
  }
}
