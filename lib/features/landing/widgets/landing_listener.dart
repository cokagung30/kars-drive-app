import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/features/landing/landing.dart';

class LandingListener extends StatelessWidget {
  const LandingListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LandingBloc, bool>(
      listenWhen: (p, c) => p != c,
      listener: (context, state) {
        if (state) {
          context.goNamed('login');
        }
      },
      child: child,
    );
  }
}
