import 'package:flutter/material.dart';

void showAppBottomSheet(
  BuildContext context, {
  required Widget child,
  bool isScrollControlled = true,
  bool isDismissible = true,
  bool enableDrag = true,
}) {
  showModalBottomSheet<dynamic>(
    context: context,
    isScrollControlled: isScrollControlled,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    useRootNavigator: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    builder: (_) => child,
  );
}
