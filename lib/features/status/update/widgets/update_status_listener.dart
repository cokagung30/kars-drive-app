import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/features/status/update/update_status.dart';

class UpdateStatusListener extends StatelessWidget {
  const UpdateStatusListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateStatusBloc, UpdateStatusState>(
      listenWhen: (p, c) => p.submitStatus != c.submitStatus,
      listener: (context, state) {
        if (state.submitStatus.isError) {
          context.showDefaultToast(
            'Status gagal diperbarui, silahkan coba lagi',
            gravity: ToastGravity.BOTTOM,
          );
        }

        if (state.submitStatus.isSuccess) {
          context
            ..pop()
            ..showDefaultToast(
              'Status berhasil diperbarui',
              gravity: ToastGravity.BOTTOM,
            );
        }
      },
      child: child,
    );
  }
}
