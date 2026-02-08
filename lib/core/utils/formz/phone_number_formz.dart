import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

enum PhoneNumberValidationError { required, min, max }

class PhoneNumberFormz extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumberFormz.dirty([super.value = '']) : super.dirty();
  const PhoneNumberFormz.pure([super.value = '']) : super.pure();

  @override
  PhoneNumberValidationError? validator(String value) {
    if (value.isEmpty) return PhoneNumberValidationError.required;

    if (value.length < 10) return PhoneNumberValidationError.min;

    if (value.length > 14) return PhoneNumberValidationError.max;

    return null;
  }
}

extension PhoneNumberFormzX on PhoneNumberFormz {
  Color get focusBorderColor {
    return displayError != null ? ColorName.candyRed : ColorName.atenoBlue;
  }

  Color get enableBorderColor {
    return displayError != null ? ColorName.candyRed : ColorName.quickSilver;
  }

  String? get errorMessage {
    if (displayError == PhoneNumberValidationError.required) {
      return 'Nomor telepon tidak boleh kosong';
    }

    if (displayError == PhoneNumberValidationError.min) {
      return 'Panjang nomor telepon minimal mengandung 10 karakter';
    }

    if (displayError == PhoneNumberValidationError.max) {
      return 'Panjang nomor telepon maximal mengandung 15 karakter';
    }

    return null;
  }
}
