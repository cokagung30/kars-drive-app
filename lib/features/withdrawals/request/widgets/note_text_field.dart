import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/withdrawals/request/withdraw_request.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class NoteTextField extends StatelessWidget {
  const NoteTextField({
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
      (value) => value.state.descriptionFocus,
    );

    return AppTextField<String>(
      controller: controller,
      focusNode: focusNode,
      isFocused: isFocused,
      labelText: 'Pesan',
      labelTextStyle: textTheme.labelLarge,
      inputTextStyle: textTheme.labelSmall,
      hintText: 'Masukkan pesan penarikan',
      hintTextStyle: textTheme.labelSmall?.copyWith(
        color: ColorName.romanSilver,
      ),
      enableBorderColor: ColorName.romanSilver,
      maxLine: 5,
      onChanged: (text) {
        final event = DescriptionChanged(text);
        context.read<WithdrawRequestBloc>().add(event);
      },
    );
  }
}
