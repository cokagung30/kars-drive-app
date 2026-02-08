import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    required this.controller,
    required this.onChange,
    super.key,
  });

  final TextEditingController controller;

  final void Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AppTextField<String>(
        controller: controller,
        hintText: 'Cari Bank',
        suffixIconConstraints: const BoxConstraints(),
        enableBorderColor: ColorName.romanSilver,
        focusBorderColor: ColorName.atenoBlue,
        inputTextStyle: textTheme.labelSmall,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: SvgPicture.asset(
            Assets.icons.icSearchOutlined.path,
            width: 16,
            height: 16,
            colorFilter: const ColorFilter.mode(
              ColorName.romanSilver,
              BlendMode.srcIn,
            ),
          ),
        ),
        onChanged: onChange,
      ),
    );
  }
}
