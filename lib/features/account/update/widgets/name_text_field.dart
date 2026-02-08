import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/account/update/update_account.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({
    required this.controller,
    required this.focusNode,
    super.key,
  });

  final TextEditingController controller;

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final name = context.select<UpdateAccountBloc, NameFormz>(
      (value) => value.state.name,
    );

    final hasFocus = context.select<UpdateAccountBloc, bool>(
      (value) => value.state.hasNameFocus,
    );

    return AppTextField<String>(
      controller: controller,
      focusNode: focusNode,
      isFocused: hasFocus,
      labelText: 'Nama',
      hintText: 'Masukkan nama',
      hintTextStyle: textTheme.labelSmall?.copyWith(
        color: ColorName.romanSilver,
      ),
      inputTextStyle: textTheme.labelMedium,
      keyboardType: TextInputType.text,
      hasValidationSymbol: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelTextStyle: textTheme.labelLarge,
      enableBorderColor: name.enableBorderColor,
      focusBorderColor: name.focusBorderColor,
      errorText: name.message,
      onChanged: (value) {
        final event = NameChanged(value);
        context.read<UpdateAccountBloc>().add(event);
      },
    );
  }
}
