import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/utils/build_context_ext.dart';
import 'package:kars_driver_app/features/login/login.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => __LoginViewState();
}

class __LoginViewState extends State<_LoginView> {
  final _emailController = TextEditingController();

  final _emailFocusNode = FocusNode();

  final _passwordFocusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _emailFocusNode.addListener(() {
      final event = EmailFocused(hasFocus: _emailFocusNode.hasFocus);
      context.read<LoginBloc>().add(event);
    });

    _passwordFocusNode.addListener(() {
      final event = PasswordFocused(hasFocus: _passwordFocusNode.hasFocus);
      context.read<LoginBloc>().add(event);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return LoginListener(
      child: Scaffold(
        body: SafeArea(
          child: Scaffold(
            backgroundColor: ColorName.cultured,
            body: AutofillGroup(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: ListView(
                  children: [
                    const SizedBox(height: 24),
                    Image.asset(
                      Assets.images.logo.path,
                      height: 80,
                      width: 80,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Selamat Datang',
                      style: textTheme.titleLarge?.copyWith(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Masukkan kredensial anda disini',
                      style: textTheme.bodySmall?.copyWith(
                        color: ColorName.quickSilver,
                      ),
                    ),
                    const SizedBox(height: 28),
                    EmailTextField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                    ),
                    const SizedBox(height: 16),
                    PasswordTextField(focusNode: _passwordFocusNode),
                    const SizedBox(height: 16),
                    const ForgotPasswordButton(),
                    const SizedBox(height: 20),
                    const ErrorMessageSection(),
                    const LoginButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
