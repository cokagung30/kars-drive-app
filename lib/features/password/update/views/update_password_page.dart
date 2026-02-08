import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/password/update/update_password.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class UpdatePasswordPage extends StatelessWidget {
  const UpdatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UpdatePasswordBloc(),
      child: const _UpdatePasswordView(),
    );
  }
}

class _UpdatePasswordView extends StatefulWidget {
  const _UpdatePasswordView();

  @override
  State<_UpdatePasswordView> createState() => __UpdatePasswordViewState();
}

class __UpdatePasswordViewState extends State<_UpdatePasswordView> {
  final _newPasswordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _newPasswordFocusNode.addListener(() {
      final event = PasswordFocused(isFocused: _newPasswordFocusNode.hasFocus);

      context.read<UpdatePasswordBloc>().add(event);
    });

    _confirmPasswordFocusNode.addListener(() {
      final event = ConfirmPasswordFocused(
        isFocused: _confirmPasswordFocusNode.hasFocus,
      );

      context.read<UpdatePasswordBloc>().add(event);
    });
  }

  @override
  void dispose() {
    _newPasswordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return UpdatePasswordListener(
      child: Scaffold(
        body: SafeArea(
          child: Scaffold(
            backgroundColor: ColorName.cultured,
            appBar: CustomAppBar(
              title: 'Perbaharui Kata Sandi',
              titleStyle: textTheme.headlineLarge,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Column(
                // spacing: 16,
                children: [
                  NewPasswordTextField(focusNode: _newPasswordFocusNode),
                  const SizedBox(height: 16),
                  ConfirmPasswordTextField(
                    focusNode: _confirmPasswordFocusNode,
                  ),
                  const SizedBox(height: 24),
                  const SubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
