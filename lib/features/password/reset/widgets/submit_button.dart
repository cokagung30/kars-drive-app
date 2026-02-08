import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/password/reset/reset_password.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final isSubmitLoading = context.select<ResetPasswordBloc, bool>(
      (value) => value.state.submitStatus.isLoading,
    );

    return AppButton.elevated(
      label: 'Ubah Kata Sandi',
      width: double.infinity,
      textStyle: textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      isLoading: isSubmitLoading,
      onTap: () {
        context.read<ResetPasswordBloc>().add(const FormSubmitted());
      },
    );
  }
}
