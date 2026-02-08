import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/app/bloc/app_bloc.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/features/account/main/views/account_page.dart';
import 'package:kars_driver_app/features/account/update/update_account.dart';
import 'package:kars_driver_app/features/dashboard/dashboard.dart';
import 'package:kars_driver_app/features/history/history.dart';
import 'package:kars_driver_app/features/landing/landing.dart';
import 'package:kars_driver_app/features/login/login.dart';
import 'package:kars_driver_app/features/main/main.dart';
import 'package:kars_driver_app/features/notification/notification.dart';
import 'package:kars_driver_app/features/orders/detail/detail_order.dart';
import 'package:kars_driver_app/features/orders/update/order_update.dart';
import 'package:kars_driver_app/features/orders/main/orders.dart';
import 'package:kars_driver_app/features/password/forgot/forgot_password.dart';
import 'package:kars_driver_app/features/password/reset/reset_password.dart';
import 'package:kars_driver_app/features/password/update/update_password.dart';
import 'package:kars_driver_app/features/withdrawals/main/withdrawals.dart';
import 'package:kars_driver_app/features/withdrawals/request/withdraw_request.dart';
import 'package:kars_driver_app/router/animations/animation.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

String? unAuthenticatedRedirect(BuildContext context) {
  final state = context.read<AppBloc>().state;

  if (state.appStatus == AppStatus.unauthenticated) {
    if (state.setting != null && state.setting!.isIntroDone) {
      return '/login';
    }

    return null;
  }

  return '/dashboard';
}

String? authenticatedRedirect(BuildContext context) {
  final state = context.read<AppBloc>().state;

  if (state.appStatus == AppStatus.unauthenticated) {
    if (state.setting != null && state.setting!.isIntroDone) {
      return '/login';
    } else {
      return '/landing';
    }
  }

  return null;
}

final routers = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/landing',
  routes: [
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/landing',
      name: 'landing',
      redirect: (context, _) => unAuthenticatedRedirect(context),
      pageBuilder: (_, _) {
        return SlideUpTransitionPage(child: const LandingPage());
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/login',
      name: 'login',
      redirect: (context, _) => unAuthenticatedRedirect(context),
      pageBuilder: (_, _) {
        return SlideTransitionPage(child: const LoginPage());
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/password/forgot',
      name: 'forgot-password',
      pageBuilder: (_, _) {
        return SlideTransitionPage(child: const ForgotPasswordPage());
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/password/reset',
      name: 'reset-password',
      pageBuilder: (_, state) {
        final extra = state.extra;

        if (extra == null) {
          throw Exception('Reset password extra cannot be null');
        }

        if (extra is! String) {
          throw Exception('Reset password extra is not string type');
        }

        return SlideTransitionPage(child: ResetPasswordPage(email: extra));
      },
    ),
    StatefulShellRoute(
      builder: (context, state, navigationShell) {
        return navigationShell;
      },
      navigatorContainerBuilder: (context, navigationShell, children) {
        return MainPage(navigationShell: navigationShell, children: children);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/order',
              redirect: (context, _) => authenticatedRedirect(context),
              builder: (_, _) => const OrdersPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              redirect: (context, _) => authenticatedRedirect(context),
              builder: (_, _) => const DashboardPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/withdraw-history',
              redirect: (context, _) => authenticatedRedirect(context),
              builder: (_, _) => const WithdrawalsPage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/order/detail',
      name: 'order-detail',
      redirect: (context, _) => authenticatedRedirect(context),
      pageBuilder: (_, state) {
        final extra = state.extra;

        if (extra == null) throw Exception('Order Detail extra cannot be null');

        if (extra is! DetailOrderExtra) {
          throw Exception('Order detail extra is not DetailOrderExtra type');
        }

        return SlideUpTransitionPage(child: DetailOrderPage(extra));
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/order/finish',
      name: 'order-finish',
      redirect: (context, _) => authenticatedRedirect(context),
      pageBuilder: (_, state) {
        final extra = state.extra;

        if (extra == null) throw Exception('Finish order extra cannot be null');

        if (extra is! OrderUpdateExtra) {
          throw Exception('Finish order extra is no OrderUpdateExtra type');
        }

        return SlideTransitionPage(child: OrderUpdatePage(extra: extra));
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/account',
      name: 'account',
      pageBuilder: (_, _) {
        return SlideTransitionPage(child: const AccountPage());
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/account/update',
      name: 'update-account',
      redirect: (context, _) => authenticatedRedirect(context),
      pageBuilder: (_, _) {
        return SlideTransitionPage(child: const UpdateAccountPage());
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/password/update',
      name: 'update-password',
      redirect: (context, _) => authenticatedRedirect(context),
      pageBuilder: (_, _) {
        return SlideTransitionPage(child: const UpdatePasswordPage());
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/history',
      name: 'history',
      redirect: (context, _) => authenticatedRedirect(context),
      pageBuilder: (_, _) {
        return SlideTransitionPage(child: const HistoryPage());
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/withdraw/request',
      name: 'withdraw-request',
      redirect: (context, _) => authenticatedRedirect(context),
      pageBuilder: (_, _) {
        return SlideTransitionPage(child: const WithdrawRequestPage());
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/withdraw/request/update',
      name: 'withdraw-request-update',
      redirect: (context, state) => authenticatedRedirect(context),
      pageBuilder: (_, state) {
        final extra = state.extra;

        if (extra == null) {
          throw Exception('Withdraw request extra cannot be null');
        }

        if (extra is! Withdraw) {
          throw Exception('Withdraw extra must be Withdraw type');
        }

        return SlideTransitionPage(child: WithdrawRequestPage(extra: extra));
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/notification',
      name: 'notification',
      redirect: (context, _) => authenticatedRedirect(context),
      pageBuilder: (_, _) {
        return SlideTransitionPage(child: const NotificationPage());
      },
    ),
  ],
);
