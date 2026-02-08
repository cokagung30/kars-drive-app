import 'package:flutter/material.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class BulletList extends StatelessWidget {
  const BulletList({
    this.count = 3,
    this.size = 4,
    this.spacing = 2,
    this.color = ColorName.goldenPoppy,
    super.key,
  });

  final int count;

  final double size;

  final double spacing;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: spacing,
      children: List.generate(count, (_) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        );
      }),
    );
  }
}
