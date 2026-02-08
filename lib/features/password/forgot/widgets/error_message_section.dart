import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/password/forgot/forgot_password.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class ErrorMessageSection extends StatelessWidget {
  const ErrorMessageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final message = context.select<ForgotPasswordBloc, String?>(
      (value) => value.state.errorMesage,
    );

    return ConditionWidget(
      isFirstCondition: message != null && message.isNotEmpty,
      firstChild: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          message ?? '',
          style: textTheme.labelSmall?.copyWith(color: ColorName.candyRed),
        ),
      ),
      secondChild: const SizedBox.shrink(),
    );
  }
}
