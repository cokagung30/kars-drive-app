import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/login/login.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final isLoading = context.select<LoginBloc, bool>(
      (value) => value.state.isLoading,
    );

    return AppButton.elevated(
      label: 'Masuk',
      textStyle: textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      isLoading: isLoading,
      onTap: isLoading
          ? null
          : () => context.read<LoginBloc>().add(const FormSubmitted()),
    );
  }
}
