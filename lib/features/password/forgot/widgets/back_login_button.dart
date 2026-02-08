import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class BackLoginButton extends StatelessWidget {
  const BackLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return AppButton.text(
      label: 'Kembali ke login',
      textStyle: textTheme.labelLarge?.copyWith(color: ColorName.atenoBlue),
      onTap: () => context.pop(),
    );
  }
}
