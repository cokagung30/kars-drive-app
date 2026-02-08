import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/account/update/update_account.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({
    required this.controller,
    required this.focusNode,
    super.key,
  });

  final TextEditingController controller;

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final phoneNumber = context.select<UpdateAccountBloc, PhoneNumberFormz>(
      (value) => value.state.phoneNumber,
    );

    final hasFocus = context.select<UpdateAccountBloc, bool>(
      (value) => value.state.hasPhoneNumberFocus,
    );

    return AppTextField<String>(
      controller: controller,
      focusNode: focusNode,
      isFocused: hasFocus,
      hasValidationSymbol: true,
      labelText: 'Nomor Telepon',
      hintText: 'Masukkan nomor telepon',
      hintTextStyle: textTheme.labelSmall?.copyWith(
        color: ColorName.romanSilver,
      ),
      inputTextStyle: textTheme.labelMedium,
      keyboardType: TextInputType.phone,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelTextStyle: textTheme.labelLarge,
      enableBorderColor: phoneNumber.enableBorderColor,
      focusBorderColor: phoneNumber.focusBorderColor,
      errorText: phoneNumber.errorMessage,
      onChanged: (value) {
        final event = PhoneNumberChanged(value);
        context.read<UpdateAccountBloc>().add(event);
      },
    );
  }
}
