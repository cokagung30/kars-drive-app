import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/withdrawals/request/withdraw_request.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class AccountNameTextField extends StatelessWidget {
  const AccountNameTextField({
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
      (value) => value.state.accountNameFocus,
    );

    final accountName = context.select<WithdrawRequestBloc, AccountNameFormz>(
      (value) => value.state.accountName,
    );

    return AppTextField<String>(
      controller: controller,
      focusNode: focusNode,
      isFocused: isFocused,
      labelText: 'Pemilik Rekening',
      hintText: 'Masukkan nama pemilik rekening',
      hintTextStyle: textTheme.labelSmall?.copyWith(
        color: ColorName.romanSilver,
      ),
      keyboardType: TextInputType.text,
      hasValidationSymbol: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      labelTextStyle: textTheme.labelLarge,
      inputTextStyle: textTheme.labelSmall,
      enableBorderColor: accountName.enableBorderColor,
      focusBorderColor: accountName.focusBorderColor,
      errorText: accountName.displayError?.message,
      onChanged: (text) {
        final event = AccountNameChanged(text);
        context.read<WithdrawRequestBloc>().add(event);
      },
    );
  }
}
