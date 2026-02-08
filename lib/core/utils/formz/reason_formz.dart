import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

enum ReasonValidationError { required }

class ReasonFormz extends FormzInput<String, ReasonValidationError> {
  const ReasonFormz.pure([super.value = '']) : super.pure();
  const ReasonFormz.dirty([super.value = '']) : super.dirty();

  @override
  ReasonValidationError? validator(String value) {
    if (value.isEmpty) return ReasonValidationError.required;
    return null;
  }
}

extension ReasonFormzX on ReasonFormz {
  Color get focusBorderColor {
    return displayError != null ? ColorName.candyRed : ColorName.atenoBlue;
  }

  Color get enableBorderColor {
    return displayError != null ? ColorName.candyRed : ColorName.quickSilver;
  }

  String? get errorMessage {
    if (displayError != null) {
      if (displayError == ReasonValidationError.required) {
        return 'Alasan tidak boleh kosong';
      }

      return null;
    }

    return null;
  }
}
