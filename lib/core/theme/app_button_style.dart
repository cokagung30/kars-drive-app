import 'package:flutter/material.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

abstract class AppButtonStyle {
  static final elevated = ButtonStyle(
    padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(12)),
    backgroundColor: WidgetStateProperty.all<Color>(ColorName.atenoBlue),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: ColorName.atenoBlue),
      ),
    ),
  );

  static final outlined = ButtonStyle(
    padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(12)),
    backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: ColorName.romanSilver),
      ),
    ),
  );

  static final text = ButtonStyle(
    padding: const WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.all(12)),
    backgroundColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
    shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
