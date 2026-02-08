import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/models/load_status.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/status/update/update_status.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class ReasonTextField extends StatelessWidget {
  const ReasonTextField({
    required this.controller,
    required this.focusNode,
    super.key,
  });

  final TextEditingController controller;

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final reason = context.select<UpdateStatusBloc, ReasonFormz>(
      (value) => value.state.reason,
    );

    final hasFocus = context.select<UpdateStatusBloc, bool>(
      (value) => value.state.hasReasonFocus,
    );

    final isLoading = context.select<UpdateStatusBloc, bool>(
      (value) => value.state.submitStatus.isLoading,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: AppTextField<String>(
        controller: controller,
        focusNode: focusNode,
        isFocused: hasFocus,
        isReadOnly: isLoading,
        labelText: 'Alasan',
        labelTextStyle: textTheme.labelLarge,
        hintText: 'Masukkan alasan anda',
        hintTextStyle: textTheme.labelSmall?.copyWith(
          color: ColorName.romanSilver,
        ),
        hasValidationSymbol: true,
        enableBorderColor: reason.enableBorderColor,
        focusBorderColor: reason.focusBorderColor,
        maxLine: 5,
        onChanged: (text) {
          final event = ReasonChanged(text);
          context.read<UpdateStatusBloc>().add(event);
        },
      ),
    );
  }
}
