import 'package:flutter/material.dart';
import 'package:kars_driver_app/core/utils/utils.dart';

class AppBadge extends StatelessWidget {
  const AppBadge({required this.color, required this.label, super.key});

  final Color color;

  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          label,
          style: textTheme.labelLarge?.copyWith(fontSize: 10),
        ),
      ),
    );
  }
}
