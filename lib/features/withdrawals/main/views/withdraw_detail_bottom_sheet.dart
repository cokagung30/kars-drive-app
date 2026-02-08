import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/withdrawals/main/models/models.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

void showWithdrawDetailBottomSheet(BuildContext context, Withdraw withdraw) {
  return showAppBottomSheet(
    context,
    child: _WithdrawDetailBottomSheet(withdraw),
  );
}

class _WithdrawDetailBottomSheet extends StatelessWidget {
  const _WithdrawDetailBottomSheet(this.withdraw);

  final Withdraw withdraw;

  String get requestDate {
    return Jiffy.parse(
      withdraw.requestDate.toIso8601String(),
      isUtc: true,
    ).format(pattern: 'dd MMMM yyyy');
  }

  String get processedDate {
    if (withdraw.processDate == null) return '-';

    return Jiffy.parse(
      DateTime.parse(withdraw.processDate!).toUtc().toIso8601String(),
      isUtc: true,
    ).format(pattern: 'dd MMMM yyyy, HH:mm');
  }

  WithdrawStatus get status {
    return withdraw.status.withdrawStatus;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return AppDynamicBottomSheet(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 16,
            top: 8,
            bottom: 16,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      'Detail Penarikan',
                      style: textTheme.headlineLarge?.copyWith(
                        color: ColorName.darkJungleBlue,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      requestDate,
                      style: textTheme.bodySmall?.copyWith(
                        color: ColorName.quickSilver,
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                color: Colors.white,
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  splashColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      Assets.icons.icClose.path,
                      width: 24,
                      height: 24,
                    ),
                  ),
                  onTap: () => context.pop(),
                ),
              ),
            ],
          ),
        ),
        Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DetailItem(
              label: 'Bank',
              value: withdraw.bankName ?? '-',
            ),
            _DetailItem(
              label: 'Nomor Rekening',
              value: withdraw.bankAccountNumber,
            ),
            _DetailItem(
              label: 'Pemiliki Rekening',
              value: withdraw.bankAccountName,
            ),
            _DetailItem(label: 'Waktu diproses', value: processedDate),
            _DetailItem(
              label: 'Nominal Diajukan',
              value: 'Rp ${withdraw.amountRequest.formatCurrency}',
            ),
            if (withdraw.amountApproved != null) ...[
              _DetailItem(
                label: 'Nominal Disetujui',
                value: 'Rp ${withdraw.amountApproved.formatCurrency}',
              ),
            ],
            _DetailItem(
              label: 'Status',
              value: status.model.label,
              valueTextColor: status.model.color,
            ),
            if (withdraw.note != null) ...[
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Catatan',
                      style: textTheme.labelSmall?.copyWith(
                        color: ColorName.romanSilver,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const CustomDivider(),
                    const SizedBox(height: 8),
                    Text(
                      withdraw.note ?? '',
                      style: textTheme.labelSmall?.copyWith(
                        color: ColorName.darkJungleBlue,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _DetailItem extends StatelessWidget {
  const _DetailItem({
    required this.label,
    required this.value,
    this.valueTextColor = ColorName.darkJungleBlue,
  });

  final String label;

  final String value;

  final Color valueTextColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 8),
      child: Column(
        spacing: 4,
        children: [
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: textTheme.labelSmall?.copyWith(
                    color: ColorName.romanSilver,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  value,
                  style: textTheme.labelMedium?.copyWith(color: valueTextColor),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          const CustomDivider(),
        ],
      ),
    );
  }
}
