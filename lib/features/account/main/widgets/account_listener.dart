import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/core/models/load_status.dart';
import 'package:kars_driver_app/core/utils/toast_utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/account/main/account.dart';

class AccountListener extends StatelessWidget {
  const AccountListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listenWhen: (p, c) => p.logoutStatus != c.logoutStatus,
      listener: (context, state) {
        if (state.logoutStatus.isLoading) {
          context.pop();
          showLoadingDialog(context);
        }

        if (state.logoutStatus.isError) {
          context
            ..pop()
            ..showDefaultToast(
              'Logout gagal, silahkan coba lagi',
              gravity: ToastGravity.BOTTOM,
            );
        }

        if (state.logoutStatus.isSuccess) {
          context
            ..pop()
            ..showDefaultToast(
              'Logout berhasil, sampai jumpa lagi',
              gravity: ToastGravity.BOTTOM,
            )
            ..goNamed('login');
        }
      },
      child: child,
    );
  }
}
