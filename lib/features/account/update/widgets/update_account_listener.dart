import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/toast_utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/account/update/update_account.dart';

class UpdateAccountListener extends StatelessWidget {
  const UpdateAccountListener({
    required this.child,

    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateAccountBloc, UpdateAccountState>(
      listenWhen: (p, c) {
        return p.submitStatus != c.submitStatus;
      },
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
            ..showDefaultToast('Pembaharuan akun berhasil!');
        }
      },
      child: child,
    );
  }
}
