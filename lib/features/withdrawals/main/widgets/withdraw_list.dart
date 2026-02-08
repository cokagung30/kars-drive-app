import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/withdrawals/main/withdrawals.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class WithdrawList extends StatelessWidget {
  const WithdrawList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WithdrawlsBloc, WithdrawlsState>(
      buildWhen: (p, c) => p.status != c.status,
      builder: (context, state) {
        final isLoading = state.status.isLoading;

        if (isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: ColorName.atenoBlue,
            ),
          );
        }

        final withdrawls = state.withdrawls;

        return ConditionWidget(
          isFirstCondition: withdrawls.isEmpty,
          firstChild: Center(
            child: EmptyView(
              onRefresh: () => _onRefresh(context),
            ),
          ),
          secondChild: RefreshIndicator(
            onRefresh: () => _onRefresh(context),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                spacing: 12,
                children: withdrawls.map((withdraw) {
                  return _WithdrawItem(withdraw);
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<WithdrawlsBloc>().add(const WithdrawHistoryFetched());
  }
}

class _WithdrawItem extends StatelessWidget {
  const _WithdrawItem(this.withdraw);

  final Withdraw withdraw;

  String get requestDate {
    return Jiffy.parse(
      withdraw.requestDate.toIso8601String(),
      isUtc: true,
    ).format(pattern: 'dd MMMM yyyy');
  }

  WithdrawStatus get status {
    return withdraw.status.withdrawStatus;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorName.atenoBlue, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          if (status != WithdrawStatus.pending) {
            showWithdrawDetailBottomSheet(context, withdraw);
          } else {
            context.pushNamed('withdraw-request-update', extra: withdraw);
          }
        },
        splashColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              SvgPicture.asset(Assets.icons.icWithdraw.path, height: 32),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status.model.label,
                    style: textTheme.labelLarge?.copyWith(
                      fontSize: 10,
                      color: status.model.color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    requestDate,
                    style: textTheme.labelSmall?.copyWith(fontSize: 12),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      withdraw.bankName ?? '-',
                      style: textTheme.labelLarge?.copyWith(fontSize: 12),
                    ),
                    Text(
                      withdraw.amountRequest.formatCurrency,
                      style: textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorName.atenoBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
