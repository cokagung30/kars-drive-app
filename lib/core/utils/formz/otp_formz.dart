import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

enum OtpValidaiton { required }

class OtpFormz extends FormzInput<String, OtpValidaiton> {
  const OtpFormz.dirty([super.value = '']) : super.dirty();
  const OtpFormz.pure([super.value = '']) : super.pure();

  @override
  OtpValidaiton? validator(String value) {
    if (value.isEmpty) return OtpValidaiton.required;

    return null;
  }
}

extension OtpFormzX on OtpFormz {
  Color get focusBorderColor {
    return displayError != null ? ColorName.candyRed : ColorName.atenoBlue;
  }

  Color get enableBorderColor {
    return displayError != null ? ColorName.candyRed : ColorName.quickSilver;
  }

  String? get errorMessage {
    if (displayError == OtpValidaiton.required) {
      return 'Otp tidak boleh kosong';
    }

    return null;
  }
}
