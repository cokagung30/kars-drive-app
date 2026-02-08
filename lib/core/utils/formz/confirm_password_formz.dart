import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

enum ConfirmPasswordValidationError { required, mustMatch }

class ConfirmPasswordFormz
    extends FormzInput<String, ConfirmPasswordValidationError> {
  const ConfirmPasswordFormz.pure({String value = ''})
    : password = '',
      super.pure(value);

  const ConfirmPasswordFormz.dirty({
    required this.password,
    String value = '',
  }) : super.dirty(value);

  final String password;

  @override
  ConfirmPasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return ConfirmPasswordValidationError.required;
    }

    if (password != value) {
      return ConfirmPasswordValidationError.mustMatch;
    }

    return null;
  }
}

extension ConfirmPasswordFormzX on ConfirmPasswordFormz {
  Color get focusBorderColor {
    return displayError != null ? ColorName.candyRed : ColorName.atenoBlue;
  }

  Color get enableBorderColor {
    return displayError != null ? ColorName.candyRed : ColorName.quickSilver;
  }

  String? get errorMessage {
    if (displayError == ConfirmPasswordValidationError.required) {
      return 'Konfirmasi kata sandi tidak boleh kosong';
    }

    if (displayError == ConfirmPasswordValidationError.mustMatch) {
      return 'Konfirmasi kata sandi tidak sama dengan kata sandi';
    }

    return null;
  }
}
