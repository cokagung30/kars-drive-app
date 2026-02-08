import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/landing/landing.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LandingBloc(),
      child: const _LandingView(),
    );
  }
}

class _LandingView extends StatelessWidget {
  const _LandingView();

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return LandingListener(
      child: Scaffold(
        body: SafeArea(
          child: Scaffold(
            backgroundColor: ColorName.cultured,
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 32,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: SvgPicture.asset(
                            Assets.images.landingIllustration.path,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Temukan Pesanan Travel dan Dapatkan Penghasilan',
                          style: textTheme.titleLarge?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorName.darkJungleBlue,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          // ignore: lines_longer_than_80_chars
                          'Nikmati fitur real-time yang mempermudah Anda dalam mencari penumpang dan mengantar mereka ke tujuan dengan cepat dan aman.',
                          style: textTheme.labelSmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  AppButton.elevated(
                    label: 'Masuk Disini',
                    textStyle: textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    onTap: () {
                      context.read<LandingBloc>().add(const IntroDoneSaved());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
