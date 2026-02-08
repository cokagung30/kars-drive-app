import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/core/widgets/widgets.dart';
import 'package:kars_driver_app/features/account/update/update_account.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class UserAvatarInput extends StatelessWidget {
  const UserAvatarInput(this.currentAvatar, {super.key});

  final String? currentAvatar;

  @override
  Widget build(BuildContext context) {
    final selectedPhoto = context.select<UpdateAccountBloc, String>(
      (value) => value.state.avatar,
    );

    return Stack(
      children: [
        ConditionWidget(
          isFirstCondition: selectedPhoto.isNotEmpty,
          firstChild: Container(
            width: 100,
            height: 100,
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ColorName.atenoBlue,
            ),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage:
                  FileImage(File(selectedPhoto)) as ImageProvider<Object>,
            ),
          ),
          secondChild: Padding(
            padding: currentAvatar != null
                ? const EdgeInsets.only(bottom: 2)
                : EdgeInsets.zero,
            child: AppUserAvatar(
              imageUrl: currentAvatar,
              size: 100,
              borderColor: ColorName.atenoBlue,
              borderThickness: 2,
              borderRadius: 100,
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: InkWell(
            onTap: () {
              showImageOptionBottomSheet(
                context,
                onCameraTap: () => _onCameraTap(context),
                onGallery: () => _onGalleryTap(context),
              );
            },
            child: Container(
              width: 28,
              height: 28,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: ColorName.atenoBlue,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: SvgPicture.asset(
                  Assets.icons.icPencil.path,
                  width: 18,
                  height: 18,
                ),
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
    final event = AvatarChanged(path);

    context.read<UpdateAccountBloc>().add(event);
    context.pop();
  }
}
