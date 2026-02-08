import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/withdrawals/request/withdraw_request.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class AccountNumberTextField extends StatelessWidget {
  const AccountNumberTextField({
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
      (value) => value.state.accountNumberFocus,
    );

    final accountNumber = context
        .select<WithdrawRequestBloc, AccountNumberFormz>(
          (value) => value.state.accountNumber,
        );

    return AppTextField<String>(
      controller: controller,
      focusNode: focusNode,
      isFocused: isFocused,
      labelText: 'Nomor Rekening',
      hintText: 'Masukkan nomor rekening',
      hintTextStyle: textTheme.labelSmall?.copyWith(
        color: ColorName.romanSilver,
      ),
      inputTextStyle: textTheme.labelSmall,
      keyboardType: TextInputType.number,
      hasValidationSymbol: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      labelTextStyle: textTheme.labelLarge,
      enableBorderColor: accountNumber.enableBorderColor,
      focusBorderColor: accountNumber.focusBorderColor,
      errorText: accountNumber.displayError?.message,
      onChanged: (text) {
        final event = AccountNumberChanged(text);
        context.read<WithdrawRequestBloc>().add(event);
      },
    );
  }
}
