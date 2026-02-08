import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/orders/update/order_update.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class SecondPhotoProofField extends StatelessWidget {
  const SecondPhotoProofField({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final attachment = context.select<OrderUpdateBloc, String>(
      (value) => value.state.secondImageAttachment,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: const [
              TextSpan(text: 'Bukti Kedua'),
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
                      isFirstCondition: attachment.isEmpty,
                      firstChild: SvgPicture.asset(
                        Assets.images.imagePlaceholder.path,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      secondChild: ExtendedImage.file(
                        File(attachment),
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
    final event = SecondAttachmentChanged(path);

    context.read<OrderUpdateBloc>().add(event);
    context.pop();
  }
}
