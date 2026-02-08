import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';

void showImageOptionBottomSheet(
  BuildContext context, {
  required void Function() onCameraTap,
  required void Function() onGallery,
}) {
  return showAppBottomSheet(
    context,
    child: _ImageOptionView(
      onCameraTap: onCameraTap,
      onGallery: onGallery,
    ),
  );
}

class _ImageOptionView extends StatelessWidget {
  const _ImageOptionView({
    required this.onCameraTap,
    required this.onGallery,
  });

  final void Function() onCameraTap;
  final void Function() onGallery;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return AppDynamicBottomSheet(
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Pilih Gambar',
            style: textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: 16),
        CustomListTile(
          leadingWidget: SvgPicture.asset(
            Assets.icons.icCamera.path,
            width: 20,
            height: 20,
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          leftDividerWidth: 0,
          rightDividerWidth: 0,
          title: 'Ambil dari kamera',
          titleStyle: textTheme.bodySmall,
          onTap: onCameraTap,
        ),
        CustomListTile(
          leadingWidget: SvgPicture.asset(
            Assets.icons.icGallery.path,
            width: 20,
            height: 20,
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          leftDividerWidth: 0,
          rightDividerWidth: 0,
          title: 'Ambil dari galeri',
          titleStyle: textTheme.bodySmall,
          onTap: onGallery,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
