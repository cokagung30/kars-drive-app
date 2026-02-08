import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

enum PasswordValidationError { required, min }

class PasswordFormz extends FormzInput<String, PasswordValidationError> {
  const PasswordFormz.dirty({String value = '', this.minLength})
    : super.dirty(value);
  const PasswordFormz.pure({String value = ''})
    : minLength = null,
      super.pure(value);

  final num? minLength;

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.required;

    if (minLength != null && value.length < minLength!) {
      return PasswordValidationError.min;
    }

    return null;
  }
}

extension PasswordFormzX on PasswordFormz {
  Color get focusBorderColor {
    return displayError != null ? ColorName.candyRed : ColorName.atenoBlue;
  }

  Color get enableBorderColor {
    return displayError != null ? ColorName.candyRed : ColorName.quickSilver;
  }

  String? get message {
    if (displayError != null) {
      if (displayError == PasswordValidationError.required) {
        return 'Password tidak boleh kosong';
      }

      if (displayError == PasswordValidationError.min) {
        return 'Password harus memiliki panjang minimal $minLength karakter';
      }

      return null;
    }

    return null;
  }
}
