import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/login/login.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    required this.controller,
    required this.focusNode,
    super.key,
  });

  final TextEditingController controller;

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final isFocused = context.select<LoginBloc, bool>(
      (value) => value.state.emailHasFocus,
    );

    final email = context.select<LoginBloc, EmailFormz>(
      (value) => value.state.email,
    );

    final isLoading = context.select<LoginBloc, bool>(
      (value) => value.state.isLoading,
    );

    return AppTextField<String>(
      autofills: const [AutofillHints.username],
      controller: controller,
      focusNode: focusNode,
      isFocused: isFocused,
      isReadOnly: isLoading,
      labelText: 'Email',
      hintText: 'Masukkan email disini',
      hintTextStyle: textTheme.labelSmall?.copyWith(
        color: ColorName.romanSilver,
      ),
      hasValidationSymbol: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      labelTextStyle: textTheme.bodyLarge,
      enableBorderColor: email.enableBorderColor,
      focusBorderColor: email.focusBorderColor,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 14, right: 4),
        child: SvgPicture.asset(
          Assets.icons.icUserCircleOutlined.path,
          width: 20,
          height: 20,
        ),
      ),
      prefixIconConstraints: const BoxConstraints(),
      errorText: email.displayError?.message,
      onChanged: (text) {
        final event = EmailChanged(text);
        context.read<LoginBloc>().add(event);
      },
    );
  }
}
