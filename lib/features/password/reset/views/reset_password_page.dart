import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/features/password/reset/reset_password.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({required this.email, super.key});

  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResetPasswordBloc(email: email),
      child: _ResetPasswordView(email),
    );
  }
}

class _ResetPasswordView extends StatefulWidget {
  const _ResetPasswordView(this.email);

  final String email;

  @override
  State<_ResetPasswordView> createState() => __ResetPasswordViewState();
}

class __ResetPasswordViewState extends State<_ResetPasswordView> {
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _otpFocusNode = FocusNode();
  final _newPasswordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _otpFocusNode.addListener(() {
      context.read<ResetPasswordBloc>().add(
        OtpFocused(hasFocus: _otpFocusNode.hasFocus),
      );
    });

    _newPasswordFocusNode.addListener(() {
      context.read<ResetPasswordBloc>().add(
        PasswordFocused(hasFocus: _newPasswordFocusNode.hasFocus),
      );
    });

    _confirmPasswordFocusNode.addListener(() {
      context.read<ResetPasswordBloc>().add(
        ConfirmPasswordFocused(hasFocus: _confirmPasswordFocusNode.hasFocus),
      );
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    _emailFocusNode.dispose();
    _otpFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return ResetPasswordListener(
      child: Scaffold(
        body: SafeArea(
          child: Scaffold(
            backgroundColor: ColorName.cultured,
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                const SizedBox(height: 24),
                Image.asset(
                  Assets.images.logo.path,
                  height: 80,
                  width: 80,
                ),
                const SizedBox(height: 40),
                Text(
                  'Ulang Kata Sandi',
                  style: textTheme.titleLarge?.copyWith(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Masukkan kode otp serta data pembaharuan kata sandi anda',
                  style: textTheme.bodySmall?.copyWith(
                    color: ColorName.quickSilver,
                  ),
                ),
                const SizedBox(height: 28),
                OtpTextField(
                  controller: _otpController,
                  focusNode: _otpFocusNode,
                ),
                const SizedBox(height: 12),
                EmailTextField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                ),
                const SizedBox(height: 12),
                NewPasswordTextField(focusNode: _newPasswordFocusNode),
                const SizedBox(height: 12),
                ConfirmPasswordTextField(focusNode: _confirmPasswordFocusNode),
                const SizedBox(height: 14),
                const ErrorMessageSection(),
                const SubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
