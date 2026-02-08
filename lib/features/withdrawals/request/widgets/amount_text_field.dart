import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/utils/formatters/currency_input_formatter.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/withdrawals/request/withdraw_request.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class AmountTextField extends StatelessWidget {
  const AmountTextField({
    required this.controller,
    required this.focusNode,
    super.key,
  });

  final TextEditingController controller;

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final isFocused = context.select<WithdrawRequestBloc, bool>(
      (value) => value.state.amountFocus,
    );

    final amount = context.select<WithdrawRequestBloc, AmountFormz>(
      (value) => value.state.amount,
    );

    return AppTextField<String>(
      controller: controller,
      focusNode: focusNode,
      isFocused: isFocused,
      labelText: 'Nominal',
      hintText: 'Masukkan nominal penarikan',
      hintTextStyle: textTheme.labelSmall?.copyWith(
        color: ColorName.romanSilver,
      ),
      keyboardType: TextInputType.number,
      hasValidationSymbol: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      labelTextStyle: textTheme.labelLarge,
      inputTextStyle: textTheme.labelSmall,
      enableBorderColor: amount.enableBorderColor,
      focusBorderColor: amount.focusBorderColor,
      errorText: amount.displayError?.message,
      inputFormatters: [
        CurrencyInputFormatter(),
      ],
      onChanged: (text) {
        final event = AmountChanged(text);
        context.read<WithdrawRequestBloc>().add(event);
      },
    );
  }
}
