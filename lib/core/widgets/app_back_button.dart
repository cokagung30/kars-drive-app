import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onBackTap});

  final GestureTapCallback? onBackTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 14),
        child: InkWell(
          onTap: onBackTap ?? () => Navigator.maybePop(context),
          customBorder: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: SvgPicture.asset(
              Assets.icons.icArrowBack.path,
              width: 20,
              height: 20,
              colorFilter: const ColorFilter.mode(
                ColorName.darkJungleBlue,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
