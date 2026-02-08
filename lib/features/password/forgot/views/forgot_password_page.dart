import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/features/password/forgot/forgot_password.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordBloc(),
      child: const _ForgotPasswordView(),
    );
  }
}

class _ForgotPasswordView extends StatefulWidget {
  const _ForgotPasswordView();

  @override
  State<_ForgotPasswordView> createState() => __ForgotPasswordViewState();
}

class __ForgotPasswordViewState extends State<_ForgotPasswordView> {
  final _emailController = TextEditingController();

  final _emailFocusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _emailFocusNode.addListener(() {
      context.read<ForgotPasswordBloc>().add(
        EmailFocused(hasFocus: _emailFocusNode.hasFocus),
      );
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return ForgotPasswordListener(
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
                  'Lupa Kata Sandi',
                  style: textTheme.titleLarge?.copyWith(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Masukkan email anda yang terdaftar, lalu periksa email anda untuk mendapatkan kode OTP',
                  style: textTheme.bodySmall?.copyWith(
                    color: ColorName.quickSilver,
                  ),
                ),
                const SizedBox(height: 28),
                EmailTextField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                ),
                const SizedBox(height: 24),
                const ErrorMessageSection(),
                const SubmitButton(),
                const SizedBox(height: 2),
                const BackLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
