import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

enum NameValidationError { required }

class NameFormz extends FormzInput<String, NameValidationError> {
  const NameFormz.dirty([super.value = '']) : super.dirty();
  const NameFormz.pure([super.value = '']) : super.pure();

  @override
  NameValidationError? validator(String value) {
    if (value.isEmpty) return NameValidationError.required;

    return null;
  }
}

extension NameFormzX on NameFormz {
  Color get focusBorderColor {
    return displayError != null ? ColorName.candyRed : ColorName.atenoBlue;
  }

  Color get enableBorderColor {
    return displayError != null ? ColorName.candyRed : ColorName.quickSilver;
  }

  String? get message {
    if (displayError == NameValidationError.required) {
      return 'Nama tidak boleh kosong';
    }

    return null;
  }
}
