import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        color: ColorName.cultured,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: InkWell(
          onTap: () {},
          splashColor: Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: ColorName.quickSilver),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  Assets.icons.icLogoutOutlined.path,
                  colorFilter: const ColorFilter.mode(
                    ColorName.candyRed,
                    BlendMode.srcIn,
                  ),
                  width: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  'Keluar',
                  style: textTheme.labelLarge?.copyWith(
                    color: ColorName.candyRed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
