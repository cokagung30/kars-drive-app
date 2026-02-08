import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/password/reset/reset_password.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class NewPasswordTextField extends StatefulWidget {
  const NewPasswordTextField({required this.focusNode, super.key});

  final FocusNode focusNode;

  @override
  State<NewPasswordTextField> createState() => _NewPasswordTextFieldState();
}

class _NewPasswordTextFieldState extends State<NewPasswordTextField> {
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

    final password = context.select<ResetPasswordBloc, PasswordFormz>(
      (value) => value.state.password,
    );

    final hasFocus = context.select<ResetPasswordBloc, bool>(
      (value) => value.state.hasPasswordFocused,
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
      labelText: 'Kata Sandi Baru',
      hasValidationSymbol: true,
      labelTextStyle: textTheme.bodyLarge,
      enableBorderColor: password.enableBorderColor,
      focusBorderColor: password.focusBorderColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      obscureCharacter: '*',
      hintText: 'Masukkan kata sandi baru disini',
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
      errorText: password.message,
      onChanged: (text) {
        final event = PasswordChanged(text);
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
