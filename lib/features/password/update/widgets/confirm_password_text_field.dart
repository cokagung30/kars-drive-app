import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/password/update/update_password.dart';
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
        .select<UpdatePasswordBloc, ConfirmPasswordFormz>(
          (value) => value.state.confirmPassword,
        );

    final hasFocus = context.select<UpdatePasswordBloc, bool>(
      (value) => value.state.hasConfirmPasswordFocus,
    );

    return AppTextField<String>(
      obscure: obscure,
      controller: _controller,
      focusNode: widget.focusNode,
      isFocused: hasFocus,
      labelText: 'Konfirmasi Kata Sandi',
      hasValidationSymbol: true,
      labelTextStyle: textTheme.labelLarge,
      enableBorderColor: confirmPassword.enableBorderColor,
      focusBorderColor: confirmPassword.focusBorderColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      obscureCharacter: '*',
      hintText: 'Masukkan konfirmasi kata sandi',
      hintTextStyle: textTheme.labelSmall?.copyWith(
        color: ColorName.romanSilver,
      ),
      keyboardType: TextInputType.text,
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
      errorText: confirmPassword.errorMessage,
      onChanged: (text) {
        final event = ConfirmPasswordChanged(text);
        context.read<UpdatePasswordBloc>().add(event);
      },
    );
  }

  void setVisibility() {
    setState(() {
      obscure = !obscure;
    });
  }
}
