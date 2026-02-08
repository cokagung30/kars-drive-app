import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/core/utils/toast_utils.dart';
import 'package:kars_driver_app/core/widgets/loading_dialog.dart';
import 'package:kars_driver_app/features/orders/update/order_update.dart';

class FinishOrderListener extends StatelessWidget {
  const FinishOrderListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderUpdateBloc, OrderUpdateState>(
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        if (state.status == SubmitStatus.loading) {
          showLoadingDialog(context);
        }

        if (state.status == SubmitStatus.error) {
          context
            ..pop()
            ..showDefaultToast(
              'Terjadi kesalaham, silahkan coba lagi!',
              gravity: ToastGravity.BOTTOM,
            );
        }

        if (state.status == SubmitStatus.success) {
          context
            ..pop()
            ..pop()
            ..showDefaultToast(
              'Pembaharuan proses pengataran berhasil',
              gravity: ToastGravity.BOTTOM,
            );
        }
      },
      child: child,
    );
  }
}
