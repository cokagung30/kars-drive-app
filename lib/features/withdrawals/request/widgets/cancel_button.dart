import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/withdrawals/request/withdraw_request.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return AppButton.outlined(
      borderColor: ColorName.candyRed,
      label: 'Batalkan',
      width: double.infinity,
      textStyle: textTheme.labelLarge,
      textColor: ColorName.candyRed,
      onTap: () {
        const event = WithdrawCanceled();

        context.read<WithdrawRequestBloc>().add(event);
      },
    );
  }
}
