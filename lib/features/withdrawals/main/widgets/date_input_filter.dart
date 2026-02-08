import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class DateInputFilter extends StatelessWidget {
  const DateInputFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Material(
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        splashColor: Colors.transparent,
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: ColorName.atenoBlue, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                Assets.icons.icCalendarOutlined.path,
                height: 18,
                colorFilter: const ColorFilter.mode(
                  ColorName.darkJungleBlue,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Temukan Periode Penarikan',
                  style: textTheme.labelLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
