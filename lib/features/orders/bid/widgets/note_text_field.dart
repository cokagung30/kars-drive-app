import 'package:flutter/material.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class NoteTextField extends StatelessWidget {
  const NoteTextField(this.controller, {super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: AppTextField<String>(
        controller: controller,
        labelText: 'Pesan',
        labelTextStyle: textTheme.labelLarge,
        hintText: 'Masukkan pesan pengantaran',
        hintTextStyle: textTheme.labelSmall?.copyWith(
          color: ColorName.romanSilver,
        ),
        enableBorderColor: ColorName.romanSilver,
        maxLine: 5,
      ),
    );
  }
}
