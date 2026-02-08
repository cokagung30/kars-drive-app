import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/features/login/login.dart';
import 'package:kars_driver_app/router/app_router.dart';

class LoginListener extends StatelessWidget {
  const LoginListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        if (state.status.isSuccess) {
          final path = unAuthenticatedRedirect(context);
          if (path != null) context.go(path);
        }
      },
      child: child,
    );
  }
}
