import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/app_button.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key, this.onRefresh});

  final GestureTapCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.images.emptyIllustration.path,
              height: height * 0.25,
            ),
            const SizedBox(height: 16),
            Text(
              'Data yang anda cari kosong, \nsilahkan muat ulang halaman ini!',
              style: textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            AppButton.elevated(
              label: 'Muat Ulang',
              isWidthDynamic: true,
              textStyle: textTheme.labelLarge,
              onTap: onRefresh,
            ),
          ],
        ),
      ),
    );
  }
}
