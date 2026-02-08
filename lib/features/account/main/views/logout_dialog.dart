import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

void showLogoutDialog(
  BuildContext context, {
  required void Function() onLogoutTap,
}) {
  showDialog<void>(
    context: context,
    builder: (_) => LogoutDialog(onLogoutTap),
  );
}

class LogoutDialog extends StatelessWidget {
  const LogoutDialog(this.onLogoutTap, {super.key});

  final void Function() onLogoutTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SvgPicture.asset(
                      Assets.icons.icAlertTriangle.path,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        ColorName.candyRed,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  Text(
                    'Konfirmasi Keluar',
                    style: textTheme.bodyMedium?.copyWith(color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Apakah anda yakin ingin keluar?',
                style: textTheme.bodySmall?.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton.text(
                    label: 'Tidak',
                    isWidthDynamic: true,
                    textStyle: textTheme.labelLarge,
                    textColor: ColorName.darkJungleBlue,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 16),
                  AppButton.elevated(
                    label: 'Ya, keluar',
                    isWidthDynamic: true,
                    textStyle: textTheme.labelLarge,
                    backgroundColor: ColorName.candyRed,
                    onTap: onLogoutTap,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
