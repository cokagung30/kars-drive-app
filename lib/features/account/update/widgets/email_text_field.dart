import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/account/update/update_account.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    required this.controller,
    required this.focusNode,
    super.key,
  });

  final TextEditingController controller;

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final email = context.select<UpdateAccountBloc, EmailFormz>(
      (value) => value.state.email,
    );

    final hasFocus = context.select<UpdateAccountBloc, bool>(
      (value) => value.state.hasEmailFocus,
    );

    return AppTextField<String>(
      controller: controller,
      focusNode: focusNode,
      isFocused: hasFocus,
      labelText: 'Email',
      hintText: 'Masukkan email',
      hintTextStyle: textTheme.labelSmall?.copyWith(
        color: ColorName.romanSilver,
      ),
      inputTextStyle: textTheme.labelMedium,
      keyboardType: TextInputType.emailAddress,
      hasValidationSymbol: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelTextStyle: textTheme.labelLarge,
      enableBorderColor: email.enableBorderColor,
      focusBorderColor: email.focusBorderColor,
      errorText: email.displayError?.message,
      onChanged: (value) {
        final event = EmailChanged(value);
        context.read<UpdateAccountBloc>().add(event);
      },
    );
  }
}
