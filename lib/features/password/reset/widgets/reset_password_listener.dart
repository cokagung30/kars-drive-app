import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/features/password/reset/reset_password.dart';

class ResetPasswordListener extends StatelessWidget {
  const ResetPasswordListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listenWhen: (p, c) => p.submitStatus != c.submitStatus,
      listener: (context, state) {
        if (state.submitStatus.isSuccess) {
          context.pop();
        }
      },
      child: child,
    );
  }
}
