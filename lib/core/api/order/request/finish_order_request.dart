import 'dart:io';

import 'package:dio/dio.dart';

class FinishOrderRequest {
  const FinishOrderRequest({
    required this.firstAttachment,
    required this.secondAttachment,
    required this.status,
  });

  final File firstAttachment;

  final File? secondAttachment;

  final String status;

  FormData toFormData() {
    return FormData.fromMap({
      'photo_1': MultipartFile.fromFileSync(
        firstAttachment.path,
        filename: firstAttachment.path.split(Platform.pathSeparator).last,
      ),
      'photo_2': secondAttachment != null
          ? MultipartFile.fromFileSync(
              secondAttachment!.path,
              filename: secondAttachment!.path
                  .split(Platform.pathSeparator)
                  .last,
            )
          : null,
      'status': status,
    });
  }
}
