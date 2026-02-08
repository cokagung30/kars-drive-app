import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/app/bloc/app_bloc.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/theme/app_theme.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';
import 'package:kars_driver_app/injection/injection.dart';
import 'package:kars_driver_app/router/router.dart';

class App extends StatelessWidget {
  const App({required User? user, required Setting? setting, super.key})
    : _user = user,
      _setting = setting;

  final User? _user;

  final Setting? _setting;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(user: _user, setting: _setting),
      child: const _AppView(),
    );
  }
}

class _AppView extends StatefulWidget {
  const _AppView();

  @override
  State<_AppView> createState() => __AppViewState();
}

class __AppViewState extends State<_AppView> {
  @override
  void initState() {
    super.initState();

    if (kReleaseMode) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([inject.allReady()]),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return MaterialApp.router(
            routerConfig: routers,
            locale: const Locale('id'),
            theme: AppTheme.standard,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.noScaling,
                ),
                child: child ?? const SizedBox.shrink(),
              );
            },
            scrollBehavior: ScrollConfiguration.of(context).copyWith(
              multitouchDragStrategy: MultitouchDragStrategy.sumAllPointers,
            ),
          );
        }

        return const ColoredBox(color: ColorName.cultured);
      },
    );
  }
}
