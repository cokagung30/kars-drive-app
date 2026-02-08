import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/core/utils/authenticated_listener.dart';
import 'package:kars_driver_app/features/main/main.dart';

class MainListener extends StatelessWidget {
  const MainListener({
    required this.navigationShell,
    required this.child,
    super.key,
  });

  final Widget child;

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        AuthenticatedListener(),
        BlocListener<FeatureTabBarCubit, int>(
          listenWhen: (p, c) => p != c,
          listener: (context, state) {
            navigationShell.goBranch(state);
          },
        ),
      ],
      child: child,
    );
  }
}
