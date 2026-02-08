import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kars_driver_app/core/models/load_status.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/password/reset/reset_password.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class ConfirmPasswordTextField extends StatefulWidget {
  const ConfirmPasswordTextField({required this.focusNode, super.key});

  final FocusNode focusNode;

  @override
  State<ConfirmPasswordTextField> createState() =>
      _ConfirmPasswordTextFieldState();
}

class _ConfirmPasswordTextFieldState extends State<ConfirmPasswordTextField> {
  bool obscure = true;

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final confirmPassword = context
        .select<ResetPasswordBloc, ConfirmPasswordFormz>(
          (value) => value.state.confirmPassword,
        );

    final hasFocus = context.select<ResetPasswordBloc, bool>(
      (value) => value.state.hasConfirmPasswordFocused,
    );

    final isSubmitLoading = context.select<ResetPasswordBloc, bool>(
      (value) => value.state.submitStatus.isLoading,
    );

    return AppTextField<String>(
      autofills: const [AutofillHints.password],
      obscure: obscure,
      controller: _controller,
      focusNode: widget.focusNode,
      isFocused: hasFocus,
      isReadOnly: isSubmitLoading,
      labelText: 'Konfirmasi Kata Sandi',
      hasValidationSymbol: true,
      labelTextStyle: textTheme.bodyLarge,
      enableBorderColor: confirmPassword.enableBorderColor,
      focusBorderColor: confirmPassword.focusBorderColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      obscureCharacter: '*',
      hintText: 'Masukkan konfirmasi kata sandi disini',
      hintTextStyle: textTheme.labelSmall?.copyWith(
        color: ColorName.romanSilver,
      ),
      keyboardType: TextInputType.text,
      inputTextStyle: textTheme.labelSmall,
      suffixIconConstraints: const BoxConstraints(),
      suffixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: InkWell(
              onTap: setVisibility,
              child: ConditionWidget(
                isFirstCondition: obscure,
                secondChild: SvgPicture.asset(
                  Assets.icons.icEyeSlashOutlined.path,
                  colorFilter: const ColorFilter.mode(
                    ColorName.quickSilver,
                    BlendMode.srcIn,
                  ),
                  height: 20,
                ),
                firstChild: SvgPicture.asset(
                  Assets.icons.icEyeOutlined.path,
                  colorFilter: const ColorFilter.mode(
                    ColorName.quickSilver,
                    BlendMode.srcIn,
                  ),
                  height: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 14, right: 4),
        child: SvgPicture.asset(
          Assets.icons.icLockOutlined.path,
          colorFilter: const ColorFilter.mode(
            ColorName.atenoBlue,
            BlendMode.srcIn,
          ),
          height: 20,
        ),
      ),
      prefixIconConstraints: const BoxConstraints(),
      errorText: confirmPassword.errorMessage,
      onChanged: (text) {
        final event = ConfirmPasswordChanged(text);

        context.read<ResetPasswordBloc>().add(event);
      },
    );
  }

  void setVisibility() {
    setState(() {
      obscure = !obscure;
    });
  }
}
