import 'package:flutter/material.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

void showLuggageDetailBottomSheet(BuildContext context, List<String> luggages) {
  return showAppBottomSheet(
    context,
    child: _LuggageDetailBottomSheet(luggages),
  );
}

class _LuggageDetailBottomSheet extends StatelessWidget {
  const _LuggageDetailBottomSheet(this.luggages);

  final List<String> luggages;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return AppDynamicBottomSheet(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Barang Bawaan Penumpang',
            style: textTheme.headlineLarge,
          ),
        ),
        const SizedBox(height: 12),
        ...luggages.map((luggage) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  luggage,
                  style: textTheme.bodySmall,
                ),
                const SizedBox(height: 4),
                const Divider(color: ColorName.romanSilver),
              ],
            ),
          );
        }),
        const SizedBox(height: 12),
      ],
    );
  }
}
