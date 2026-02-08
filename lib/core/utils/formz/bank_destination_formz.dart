import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

enum BankDestinationValidation { required }

class BankDestinationFormz
    extends FormzInput<String, BankDestinationValidation> {
  const BankDestinationFormz.dirty([super.value = '']) : super.dirty();
  const BankDestinationFormz.pure([super.value = '']) : super.pure();

  @override
  BankDestinationValidation? validator(String value) {
    if (value.isEmpty) return BankDestinationValidation.required;

    return null;
  }
}

extension BankDestinationFormzX on BankDestinationFormz {
  Color get focusBorderColor {
    return displayError != null ? ColorName.candyRed : ColorName.atenoBlue;
  }

  Color get enableBorderColor {
    return displayError != null ? ColorName.candyRed : ColorName.quickSilver;
  }
}

extension BankDestinationValidationX on BankDestinationValidation {
  String? get message {
    if (this == BankDestinationValidation.required) {
      return 'Bank tujuan tidak boleh kosong';
    }

    return null;
  }
}
