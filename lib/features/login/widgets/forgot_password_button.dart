import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () => context.pushNamed('forgot-password'),
        child: Text(
          'Lupa Kata Sandi?',
          style: textTheme.labelMedium?.copyWith(color: ColorName.atenoBlue),
        ),
      ),
    );
  }
}
