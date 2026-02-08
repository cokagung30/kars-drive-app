import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/orders/main/orders.dart';
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
      focusNode: focusNode,
      hintText: 'Cari nama pemesan disini...',
      hintTextStyle: textTheme.labelMedium?.copyWith(
        color: ColorName.quickSilver,
      ),
      inputTextStyle: textTheme.labelMedium,
      focusBorderColor: ColorName.darkJungleBlue,
      enableBorderColor: ColorName.darkJungleBlue,
      contentPadding: const EdgeInsets.all(12),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 12, right: 8),
        child: SvgPicture.asset(
          Assets.icons.icSearchOutlined.path,
          width: 18,
          height: 18,
        ),
      ),
      prefixIconConstraints: const BoxConstraints(),
      onChanged: (text) {
        final event = SearchChanged(text);

        context.read<OrdersBloc>().add(event);
      },
    );
  }
}
