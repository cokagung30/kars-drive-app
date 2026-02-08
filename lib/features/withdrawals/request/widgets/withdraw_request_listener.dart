import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/toast_utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/withdrawals/request/withdraw_request.dart';

class WithdrawRequestListener extends StatelessWidget {
  const WithdrawRequestListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<WithdrawRequestBloc, WithdrawRequestState>(
      listenWhen: (p, c) {
        return p.submitStatus != c.submitStatus ||
            p.cancelStatus != c.cancelStatus;
      },
      listener: (context, state) {
        if (state.submitStatus.isError) {
          context.showDefaultToast(
            'Terjadi kesalahan, silahkan ulangi lagi!',
            gravity: ToastGravity.BOTTOM,
          );
        }

        if (state.submitStatus.isSuccess) {
          context.pop();
        }

        if (state.cancelStatus.isLoading) {
          showLoadingDialog(context);
        }

        if (state.cancelStatus.isError) {
          context
            ..pop()
            ..showDefaultToast(
              'Terjadi kesalahan, silahkan ulangi lagi!',
              gravity: ToastGravity.BOTTOM,
            );
        }

        if (state.cancelStatus.isSuccess) {
          context
            ..pop()
            ..pop();
        }
      },
      child: child,
    );
  }
}
