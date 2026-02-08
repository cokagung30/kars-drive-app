import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/dashboard/bloc/bloc.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class EarningOverviewCard extends StatelessWidget {
  const EarningOverviewCard({
    required this.isLoading,
    required this.summary,
    super.key,
  });

  final Summary? summary;

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.images.cardBackground.path),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pendapatan',
                    style: textTheme.labelSmall?.copyWith(
                      color: ColorName.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ConditionWidget(
                    isFirstCondition: isLoading,
                    firstChild: CustomShimmer(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: 18,
                    ),
                    secondChild: Text(
                      "${summary?.currency ?? 'Rp'} "
                      '${(summary?.income ?? 0).formatCurrency}',
                      style: textTheme.bodyLarge?.copyWith(
                        color: ColorName.white,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jml. Pengantaran',
                    style: textTheme.labelSmall?.copyWith(
                      color: ColorName.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ConditionWidget(
                    isFirstCondition: isLoading,
                    firstChild: CustomShimmer(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: 18,
                    ),
                    secondChild: Text(
                      '${summary?.totalBids} kali',
                      style: textTheme.bodyLarge?.copyWith(
                        color: ColorName.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          _EarningMoneySummarySection(
            isLoading: isLoading,
            currency: summary?.currency ?? 'Rp',
            income: summary?.balance.balance ?? 0,
          ),
        ],
      ),
    );
  }
}

class _EarningMoneySummarySection extends StatelessWidget {
  const _EarningMoneySummarySection({
    required this.isLoading,
    required this.currency,
    required this.income,
  });

  final bool isLoading;

  final String currency;

  final num income;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final isShow = context.select<DashboardBloc, bool>(
      (value) => value.state.showEarningBalance,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total Saldo',
          style: textTheme.labelSmall?.copyWith(color: ColorName.white),
        ),
        const SizedBox(height: 8),
        ConditionWidget(
          isFirstCondition: isLoading,
          firstChild: CustomShimmer(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 18,
          ),
          secondChild: Row(
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(text: '$currency '),
                    TextSpan(text: isShow ? income.formatCurrency : '********'),
                  ],
                  style: textTheme.headlineLarge?.copyWith(
                    fontSize: 20,
                    color: ColorName.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Material(
                color: Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: InkWell(
                  onTap: () {
                    final bloc = context.read<DashboardBloc>();
                    bloc.add(const ShowEarningBalanceChanged());
                  },
                  splashColor: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: SvgPicture.asset(
                      isShow
                          ? Assets.icons.icEyeSlashOutlined.path
                          : Assets.icons.icEyeOutlined.path,
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                        ColorName.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
