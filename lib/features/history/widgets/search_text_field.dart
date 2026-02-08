import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    required this.controller,
    required this.focusNode,
    super.key,
  });

  final TextEditingController controller;

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return AppTextField<String>(
      controller: controller,
      hintText: 'Cari riwayat pengantaran',
      hintTextStyle: textTheme.labelSmall?.copyWith(
        color: ColorName.romanSilver,
      ),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 12, right: 8),
        child: SvgPicture.asset(
          Assets.icons.icSearchOutlined.path,
          width: 18,
          height: 18,
          colorFilter: const ColorFilter.mode(
            ColorName.atenoBlue,
            BlendMode.srcIn,
          ),
        ),
      ),
      prefixIconConstraints: const BoxConstraints(),
      enableBorderColor: ColorName.atenoBlue,
      contentPadding: const EdgeInsets.all(12),
    );
  }
}
