import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/app/bloc/app_bloc.dart';
import 'package:kars_driver_app/router/router.dart';

class AuthenticatedListener extends BlocListener<AppBloc, AppState> {
  AuthenticatedListener({super.key, super.child})
    : super(
        listenWhen: (p, c) => p.appStatus != c.appStatus,
        listener: (context, state) {
          final path = authenticatedRedirect(context);
          if (path != null) context.go(path);
        },
      );
}
