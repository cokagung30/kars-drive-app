import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/models/load_status.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/status/update/update_status.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final isLoading = context.select<UpdateStatusBloc, bool>(
      (value) => value.state.submitStatus.isLoading,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: AppButton.elevated(
        label: 'Simpan',
        textStyle: textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        width: double.infinity,
        isLoading: isLoading,
        onTap: () {
          context.read<UpdateStatusBloc>().add(const FormSubmitted());
        },
      ),
    );
  }
}
