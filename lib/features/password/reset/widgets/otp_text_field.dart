import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/password/reset/reset_password.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class OtpTextField extends StatelessWidget {
  const OtpTextField({
    required this.controller,
    required this.focusNode,
    super.key,
  });

  final TextEditingController controller;

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final otp = context.select<ResetPasswordBloc, OtpFormz>(
      (value) => value.state.otp,
    );

    final hasFocus = context.select<ResetPasswordBloc, bool>(
      (value) => value.state.hasOtpFocused,
    );

    final isSubmitLoading = context.select<ResetPasswordBloc, bool>(
      (value) => value.state.submitStatus.isLoading,
    );

    return AppTextField<String>(
      controller: controller,
      focusNode: focusNode,
      isFocused: hasFocus,
      isReadOnly: isSubmitLoading,
      labelText: 'Kode OTP',
      hintText: 'Masukkan kode otp disini',
      hintTextStyle: textTheme.labelSmall?.copyWith(
        color: ColorName.romanSilver,
      ),
      hasValidationSymbol: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      labelTextStyle: textTheme.bodyLarge,
      enableBorderColor: otp.enableBorderColor,
      focusBorderColor: otp.focusBorderColor,
      keyboardType: TextInputType.number,
      inputTextStyle: textTheme.labelSmall,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 14, right: 4),
        child: SvgPicture.asset(
          Assets.icons.icCode.path,
          width: 20,
          height: 20,
          colorFilter: const ColorFilter.mode(
            ColorName.atenoBlue,
            BlendMode.srcIn,
          ),
        ),
      ),
      prefixIconConstraints: const BoxConstraints(),
      errorText: otp.errorMessage,
      onChanged: (text) {
        final event = OtpChanged(text);
        context.read<ResetPasswordBloc>().add(event);
      },
    );
  }
}
