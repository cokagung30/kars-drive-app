import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kars_driver_app/gen/assets.gen.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class AppUserAvatar extends StatelessWidget {
  const AppUserAvatar({
    super.key,
    this.imageUrl,
    this.borderColor,
    this.size = 40,
    this.boxFit = BoxFit.cover,
    this.borderThickness = 0,
    this.paddingImage = 0,
    this.isSizeDynamic = false,
    this.backgroundColor = Colors.white,
    this.emptyAvatar,
    this.borderRadius = 10,
  });

  final String? imageUrl;

  final double size;

  final BoxFit boxFit;

  final Color? borderColor;

  final Color backgroundColor;

  final double borderThickness;

  final double paddingImage;

  final double borderRadius;

  final bool isSizeDynamic;

  final Widget? emptyAvatar;

  Widget _buildImage(BuildContext context, ImageProvider image) {
    return Container(
      padding: EdgeInsets.all(paddingImage),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor,
        border: Border.all(
          color: borderColor ?? ColorName.cultured,
          width: borderThickness,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image(
          image: image,
          fit: boxFit,
        ),
      ),
    );
  }

  Widget _buildPlaceHolder(BuildContext context, String url) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor ?? ColorName.cultured,
          width: borderThickness,
        ),
      ),
      child: Center(
        child: SizedBox(
          width: size / 2,
          height: size / 2,
          child: const CircularProgressIndicator(
            strokeWidth: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, String url, dynamic error) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor ?? ColorName.cultured,
          width: borderThickness,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Center(
          child: Icon(
            Icons.error,
            color: ColorName.cultured,
            size: size - 5,
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      imageBuilder: _buildImage,
      placeholder: _buildPlaceHolder,
      errorWidget: _buildError,
    );
  }

  Widget _buildSizedAvatar() {
    return SizedBox(
      width: size,
      height: size,
      child: _buildAvatar(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return isSizeDynamic ? _buildAvatar() : _buildSizedAvatar();
    }

    if (emptyAvatar != null) {
      return emptyAvatar!;
    }

    return Image.asset(
      Assets.images.defaultUserAvatar.path,
      width: size,
      height: size,
    );
  }
}
