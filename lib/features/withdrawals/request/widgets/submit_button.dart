import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/withdrawals/request/withdraw_request.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final isLoading = context.select<WithdrawRequestBloc, bool>(
      (value) => value.state.submitStatus.isLoading,
    );

    return AppButton.elevated(
      label: 'Simpan',
      isLoading: isLoading,
      width: double.infinity,
      textStyle: textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      onTap: () {
        context.read<WithdrawRequestBloc>().add(const FormSubmitted());
      },
    );
  }
}
