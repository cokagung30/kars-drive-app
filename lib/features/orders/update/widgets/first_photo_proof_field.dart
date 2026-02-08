import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/orders/update/order_update.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class FirstPhotoProofField extends StatelessWidget {
  const FirstPhotoProofField({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final attachment = context.select<OrderUpdateBloc, AttachmentFormz>(
      (value) => value.state.firstImageAttachment,
    );

    final hasError = attachment.displayError;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(text: 'Bukti Pertama'),
              const WidgetSpan(child: SizedBox(width: 4)),
              TextSpan(
                text: '*',
                style: textTheme.bodyMedium?.copyWith(
                  color: ColorName.candyRed,
                ),
              ),
            ],
            style: textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: 4),
        Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              showImageOptionBottomSheet(
                context,
                onCameraTap: () => _onCameraTap(context),
                onGallery: () => _onGalleryTap(context),
              );
            },
            splashColor: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: ColorName.romanSilver),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ConditionWidget(
                      isFirstCondition: attachment.value.isEmpty,
                      firstChild: SvgPicture.asset(
                        Assets.images.imagePlaceholder.path,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      secondChild: ExtendedImage.file(
                        File(attachment.value),
                        width: double.infinity,
                        height: 140,
                        fit: BoxFit.cover,
                        shape: BoxShape.rectangle,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
        if (hasError != null) ...[
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  Assets.icons.icAlert.path,
                  width: 16,
                  height: 16,
                  colorFilter: const ColorFilter.mode(
                    ColorName.candyRed,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    attachment.errorMessage ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: ColorName.candyRed,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _onCameraTap(BuildContext context) async {
    await Permissions.cameraRequest(
      onPermissionAllowed: () async {
        final picker = ImagePicker();

        final result = await picker.pickImage(source: ImageSource.camera);

        if (result != null) {
          final tmpDir = await path_provider.getTemporaryDirectory();
          final targetName = DateTime.now().millisecondsSinceEpoch;

          final compressFile = await FlutterImageCompress.compressAndGetFile(
            result.path,
            '${tmpDir.absolute.path}_$targetName.jpg',
            quality: 50,
          );

          if (compressFile != null && context.mounted) {
            _setImagePath(context, compressFile.path);
          }
        }
      },
    );
  }

  Future<void> _onGalleryTap(BuildContext context) async {
    await Permissions.galleryRequest(
      onPermissionAllowed: () async {
        final picker = ImagePicker();

        final result = await picker.pickImage(source: ImageSource.gallery);

        if (result != null) {
          final tmpDir = await path_provider.getTemporaryDirectory();
          final targetName = DateTime.now().millisecondsSinceEpoch;

          final compressFile = await FlutterImageCompress.compressAndGetFile(
            result.path,
            '${tmpDir.absolute.path}_$targetName.jpg',
            quality: 50,
          );

          if (compressFile != null && context.mounted) {
            _setImagePath(context, compressFile.path);
          }
        }
      },
    );
  }

  void _setImagePath(BuildContext context, String path) {
    final event = FirstAttachmentChanged(path);

    context.read<OrderUpdateBloc>().add(event);
    context.pop();
  }
}
