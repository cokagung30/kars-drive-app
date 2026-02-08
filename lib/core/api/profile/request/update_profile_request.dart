import 'dart:io';

import 'package:dio/dio.dart';

class UpdateProfileRequest {
  UpdateProfileRequest({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.avatar,
  });

  final String name;

  final String email;

  final String phoneNumber;

  final File? avatar;

  FormData toFormData() {
    return FormData.fromMap(
      {
        'name': name,
        'email': email,
        'phone': phoneNumber,
        'avatar': avatar != null
            ? MultipartFile.fromFileSync(
                avatar!.path,
                filename: avatar!.path.split(Platform.pathSeparator).last,
              )
            : null,
      }..removeWhere((key, value) => value == null),
    );
  }
}
