import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:kars_driver_app/core/utils/utils.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

enum EmailValidationError { required, email }

class EmailFormz extends FormzInput<String, EmailValidationError> {
  const EmailFormz.dirty([super.value = '']) : super.dirty();
  const EmailFormz.pure([super.value = '']) : super.pure();

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) return EmailValidationError.required;

    return value.isEmailPatternValid ? null : EmailValidationError.email;
  }
}

extension EmailFormzX on EmailFormz {
  Color get focusBorderColor {
    return displayError != null ? ColorName.candyRed : ColorName.atenoBlue;
  }

  Color get enableBorderColor {
    return displayError != null ? ColorName.candyRed : ColorName.quickSilver;
  }
}

extension EmailValidationErrorX on EmailValidationError {
  String? get message {
    if (this == EmailValidationError.required) {
      return 'Email tidak boleh kosong';
    }

    if (this == EmailValidationError.email) {
      return 'Format email tidak sesuai';
    }

    return null;
  }
}
