import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class Permissions {
  static Future<void> galleryRequest({
    required void Function() onPermissionAllowed,
  }) async {
    final status = await Permission.storage.status;

    final isAndroidPlatform = Platform.isAndroid;

    if ((status.isDenied || status.isPermanentlyDenied) && isAndroidPlatform) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;

      if (deviceInfo.version.sdkInt >= 33) {
        onPermissionAllowed();

        return;
      }

      final request = await Permission.storage.request();

      if (request.isPermanentlyDenied || request.isDenied) {
        await openAppSettings();
      } else if (request.isGranted) {
        onPermissionAllowed();
      }
    } else {
      onPermissionAllowed();
    }
  }

  static Future<void> cameraRequest({
    required void Function() onPermissionAllowed,
  }) async {
    final status = await Permission.camera.status;

    final isAndroidPlatform = Platform.isAndroid;

    if ((status.isDenied || status.isPermanentlyDenied) && isAndroidPlatform) {
      final request = await Permission.camera.request();

      if (request.isPermanentlyDenied || request.isDenied) {
        await openAppSettings();
      } else if (request.isGranted) {
        onPermissionAllowed();
      }
    } else {
      onPermissionAllowed();
    }
  }

  static Future<void> deviceLocationRequest({
    required void Function() onPermissionAllowed,
  }) async {
    final status = await Permission.location.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      final request = await Permission.location.request();

      if (request.isPermanentlyDenied || request.isDenied) {
        await openAppSettings();
      } else if (request.isGranted) {
        onPermissionAllowed();
      }
    } else {
      onPermissionAllowed();
    }
  }
}
