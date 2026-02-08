import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/withdrawals/request/withdraw_request.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class BankSelectField extends StatelessWidget {
  const BankSelectField(this.banks, {super.key});

  final List<Bank> banks;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final bankDestination = context
        .select<WithdrawRequestBloc, BankDestinationFormz>(
          (value) => value.state.destinationBank,
        );

    final bankName = context.select<WithdrawRequestBloc, String?>((value) {
      final banks = value.state.banks;
      final destinationBank = value.state.destinationBank.value;

      if (destinationBank.isNotEmpty) {
        final bank = banks.where((e) => e.code == destinationBank).first;

        return bank.name;
      }

      return null;
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(text: 'Bank Destinasi '),
              TextSpan(
                text: '*',
                style: textTheme.labelLarge?.copyWith(
                  color: ColorName.candyRed,
                ),
              ),
            ],
            style: textTheme.labelLarge,
          ),
        ),
        Column(
          children: [
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () => showBankSelectBottomSheet(
                  context,
                  banks: banks,
                  onTap: (bank) {
                    final event = BankDestinationChanged(bank.code);
                    context
                      ..pop()
                      ..read<WithdrawRequestBloc>().add(event);
                  },
                  bankSelected: bankDestination.value,
                ),
                splashColor: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: bankDestination.focusBorderColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          bankName ?? 'Pilih destinasi bank',
                          style: textTheme.labelSmall,
                        ),
                      ),
                      SvgPicture.asset(
                        Assets.icons.icChevronDown.path,
                        width: 18,
                        height: 18,
                        colorFilter: const ColorFilter.mode(
                          ColorName.darkJungleBlue,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ConditionWidget(
              isFirstCondition: bankDestination.displayError?.message != null,
              firstChild: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      Assets.icons.icAlert.path,
                      width: 16,
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                        ColorName.candyRed,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        bankDestination.displayError?.message ?? '',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: ColorName.candyRed,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              secondChild: const SizedBox.shrink(),
            ),
          ],
        ),
      ],
    );
  }
}
