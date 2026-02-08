import 'package:flutter/material.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({required this.onTap, super.key});

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: AppButton.elevated(
        label: 'Simpan',
        textStyle: textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        onTap: onTap,
      ),
    );
  }
}
