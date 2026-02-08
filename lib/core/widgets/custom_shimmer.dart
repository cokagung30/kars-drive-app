import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
    this.height = 16,
    this.percentageWidth = 1.0,
    this.width,
    this.radius = 24,
  });

  const CustomShimmer.circle({
    super.key,
    this.height = 16,
    this.percentageWidth = 1.0,
    this.width,
  }) : radius = null;

  final double height;

  final double? width;

  final double percentageWidth;

  final double? radius;

  @override
  Widget build(BuildContext context) {
    assert(percentageWidth <= 1, '');

    final containerWidth =
        width ?? MediaQuery.of(context).size.width * percentageWidth;

    return SizedBox(
      width: containerWidth,
      height: height,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade200,
        highlightColor: Colors.grey.shade400,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            shape: radius == null ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: radius != null
                ? BorderRadius.circular(radius!)
                : null,
          ),
        ),
      ),
    );
  }
}
