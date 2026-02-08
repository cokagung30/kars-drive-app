import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/password/forgot/forgot_password.dart';

class ForgotPasswordListener extends StatelessWidget {
  const ForgotPasswordListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listenWhen: (p, c) => p.submitStatus != c.submitStatus,
      listener: (context, state) {
        if (state.submitStatus == LoadStatus.loading) {
          showLoadingDialog(context);
        }

        if (state.submitStatus == LoadStatus.success) {
          final email = state.email.value;

          context
            ..pop()
            ..pop()
            ..pushNamed('reset-password', extra: email);
        }

        if (state.submitStatus == LoadStatus.error) {
          context.pop();
        }
      },
      child: child,
    );
  }
}
