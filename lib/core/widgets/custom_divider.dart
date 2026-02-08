import 'package:flutter/material.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.color = ColorName.atenoBlue50,
    this.top = 0,
    this.bottom = 0,
    this.thickness = 0.5,
    this.height = 0,
  }) : isCustom = false;

  const CustomDivider.custom({
    super.key,
    this.color = ColorName.atenoBlue50,
    this.top = 0,
    this.bottom = 0,
    this.thickness = 0.5,
    this.height = 0,
  }) : isCustom = true;

  final bool isCustom;

  final Color color;

  final double bottom;

  final double top;

  final double thickness;

  final double height;

  Widget _buildDevider() {
    return Divider(
      color: color,
      thickness: thickness,
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isCustom) {
      return Container(
        margin: EdgeInsets.only(top: top, bottom: bottom),
        child: Row(
          children: [
            SizedBox(width: 20, child: _buildDevider()),
            const SizedBox(width: 4),
            Expanded(child: _buildDevider()),
            const SizedBox(width: 4),
            SizedBox(width: 20, child: _buildDevider()),
            const SizedBox(width: 4),
            SizedBox(width: 20, child: _buildDevider()),
            const SizedBox(width: 4),
            Expanded(child: _buildDevider()),
            const SizedBox(width: 4),
            SizedBox(width: 20, child: _buildDevider()),
          ],
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(top: top, bottom: bottom),
      child: _buildDevider(),
    );
  }
}
