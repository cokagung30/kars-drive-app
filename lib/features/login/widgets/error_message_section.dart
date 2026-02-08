import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/login/login.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class ErrorMessageSection extends StatelessWidget {
  const ErrorMessageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final status = context.select<LoginBloc, LoadStatus>(
      (value) => value.state.status,
    );

    final message = context.select<LoginBloc, String?>(
      (value) => value.state.errorMessage,
    );

    return ConditionWidget(
      isFirstCondition: status.isError,
      firstChild: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          message ?? 'Terjadi kesalahan, silahkan coba lagi',
          style: textTheme.labelSmall?.copyWith(color: ColorName.candyRed),
        ),
      ),
      secondChild: const SizedBox.shrink(),
    );
  }
}
