import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/loading_dialog.dart';
import 'package:kars_driver_app/features/orders/detail/detail_order.dart';

class DetailOrderListener extends StatelessWidget {
  const DetailOrderListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailOrderBloc, DetailOrderState>(
      listenWhen: (p, c) => p.pickOrderStatus != c.pickOrderStatus,
      listener: (context, state) {
        if (state.pickOrderStatus.isLoading) {
          showLoadingDialog(context);
        }

        if (state.pickOrderStatus.isError) {
          context
            ..pop()
            ..showDefaultToast(
              'Terjadi kesalahan, coba lagi',
              gravity: ToastGravity.BOTTOM,
            );
        }

        if (state.pickOrderStatus.isSuccess) {
          context
            ..pop()
            ..showDefaultToast(
              'Pengajuan berhasil!',
              gravity: ToastGravity.BOTTOM,
            )
            ..go('/dashboard');
        }
      },
      child: child,
    );
  }
}
