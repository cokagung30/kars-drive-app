import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';
import 'package:kars_driver_app/gen/fonts.gen.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    required this.onRetryTap,
    this.retryLabelButton,
    this.message,
    super.key,
  });

  final String? message;

  final String? retryLabelButton;

  final void Function() onRetryTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.images.illustrationError.path,
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 16),
          Text(
            message ?? 'Oops, Something went wrong!',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: ColorName.atenoBlue,
              fontFamily: FontFamily.poppins,
              letterSpacing: -0.13,
            ),
          ),
          const SizedBox(height: 16),
          AppButton.text(
            label: retryLabelButton ?? 'Retry',
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ColorName.cultured,
              fontFamily: FontFamily.poppins,
              letterSpacing: -0.13,
            ),
            isWidthDynamic: true,
            onTap: onRetryTap,
          ),
        ],
      ),
    );
  }
}
