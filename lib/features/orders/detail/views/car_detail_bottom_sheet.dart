import 'package:flutter/material.dart';
import 'package:kars_driver_app/core/models/models.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

void showCarDetailBottomSheet(BuildContext context, CarClass car) {
  return showAppBottomSheet(context, child: _CarDetailBottomSheet(car));
}

class _CarDetailBottomSheet extends StatelessWidget {
  const _CarDetailBottomSheet(this.car);

  final CarClass car;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return AppDynamicBottomSheet(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Detail Mobil',
            style: textTheme.headlineLarge,
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            spacing: 8,
            children: [
              Text(
                'Jenis Kendaraan',
                style: textTheme.labelSmall,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(car.name, style: textTheme.labelLarge),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(color: ColorName.romanSilver),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fasilitas Kendaraan',
                style: textTheme.labelSmall,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: car.feature.split(', ').map((feature) {
                      return Text(feature, style: textTheme.labelLarge);
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(color: ColorName.romanSilver),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contoh Kendaraan',
                style: textTheme.labelSmall,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: car.exampleCar.split(', ').map((carName) {
                      return Text(carName, style: textTheme.labelLarge);
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(color: ColorName.romanSilver),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
