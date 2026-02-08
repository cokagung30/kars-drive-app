import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

enum AccountNameValidation { required }

class AccountNameFormz extends FormzInput<String, AccountNameValidation> {
  const AccountNameFormz.dirty([super.value = '']) : super.dirty();
  const AccountNameFormz.pure([super.value = '']) : super.pure();

  @override
  AccountNameValidation? validator(String value) {
    if (value.isEmpty) return AccountNameValidation.required;

    return null;
  }
}

extension AccountNameFormzX on AccountNameFormz {
  Color get focusBorderColor {
    return displayError != null ? ColorName.candyRed : ColorName.atenoBlue;
  }

  Color get enableBorderColor {
    return displayError != null ? ColorName.candyRed : ColorName.quickSilver;
  }
}

extension AccountNameValidationX on AccountNameValidation {
  String? get message {
    if (this == AccountNameValidation.required) {
      return 'Pemilik rekening tidak boleh kosong';
    }

    return null;
  }
}
