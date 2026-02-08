import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

enum AccountNumberValidation { required }

class AccountNumberFormz extends FormzInput<String, AccountNumberValidation> {
  const AccountNumberFormz.dirty([super.value = '']) : super.dirty();
  const AccountNumberFormz.pure([super.value = '']) : super.pure();

  @override
  AccountNumberValidation? validator(String value) {
    if (value.isEmpty) return AccountNumberValidation.required;

    return null;
  }
}

extension AccountNumberFormzX on AccountNumberFormz {
  Color get focusBorderColor {
    return displayError != null ? ColorName.candyRed : ColorName.atenoBlue;
  }

  Color get enableBorderColor {
    return displayError != null ? ColorName.candyRed : ColorName.quickSilver;
  }
}

extension AccountNumberValidationX on AccountNumberValidation {
  String? get message {
    if (this == AccountNumberValidation.required) {
      return 'Nomor rekening tidak boleh kosong';
    }

    return null;
  }
}
