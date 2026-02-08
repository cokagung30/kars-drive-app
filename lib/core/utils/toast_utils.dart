import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class ToastUtils {
  const ToastUtils();

  // ignore: avoid-long-parameter-list
  void showDefaultToast(
    BuildContext context,
    String message, {
    Widget? leadingIcon,
    Widget? trailingIcon,
    TextAlign? messageAlign,
    ToastGravity gravity = ToastGravity.CENTER,
  }) {
    final child = _buildToast(
      message: message,
      color: ColorName.darkJungleBlue.withValues(alpha: 0.75),
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      messageAlign: messageAlign,
    );

    _showToast(context, child, gravity);
  }

  void _showToast(BuildContext context, Widget child, ToastGravity gravity) {
    FToast().init(context)
      ..removeQueuedCustomToasts()
      ..showToast(child: child, gravity: gravity);
  }

  Widget _buildToast({
    required String message,
    required Color color,
    TextAlign? messageAlign,
    Widget? leadingIcon,
    Widget? trailingIcon,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16, top: 12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: leadingIcon,
            ),
          Flexible(
            child: Text(
              message,
              textAlign: messageAlign,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.6,
                fontWeight: FontWeight.w600,
                fontFamily: 'NunitoSans',
              ),
            ),
          ),
          if (trailingIcon != null) trailingIcon,
        ],
      ),
    );
  }
}

extension ToastContextExt on BuildContext {
  void showDefaultToast(
    String message, {
    Widget? leadingIcon,
    Widget? trailingIcon,
    TextAlign? messageAlign,
    ToastGravity gravity = ToastGravity.CENTER,
  }) {
    const ToastUtils().showDefaultToast(
      this,
      message,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      gravity: gravity,
      messageAlign: messageAlign,
    );
  }
}
