import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/password/update/update_password.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return AppButton.elevated(
      label: 'Simpan',
      textStyle: textTheme.labelLarge,
      width: double.infinity,
      onTap: () {
        context.read<UpdatePasswordBloc>().add(const FormSubmitted());
      },
    );
  }
}
