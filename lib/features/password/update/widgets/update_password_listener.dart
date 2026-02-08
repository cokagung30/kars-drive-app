import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/loading_dialog.dart';
import 'package:kars_driver_app/features/password/update/update_password.dart';

class UpdatePasswordListener extends StatelessWidget {
  const UpdatePasswordListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdatePasswordBloc, UpdatePasswordState>(
      listenWhen: (p, c) => p.submitStatus != c.submitStatus,
      listener: (context, state) {
        if (state.submitStatus.isLoading) {
          showLoadingDialog(context);
        }

        if (state.submitStatus.isError) {
          context
            ..pop()
            ..showDefaultToast(
              'Terjadi kesalahan, silahkan coba lagi',
              gravity: ToastGravity.BOTTOM,
            );
        }

        if (state.submitStatus.isSuccess) {
          context
            ..pop()
            ..pop()
            ..showDefaultToast(
              'Password berhasil diperbaharui',
              gravity: ToastGravity.BOTTOM,
            );
        }
      },
      child: child,
    );
  }
}
