import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

enum AmountValidation { required, minBalance }

class AmountFormz extends FormzInput<num?, AmountValidation> {
  const AmountFormz.dirty({
    this.lastBalance = 0,
    num value = 0,
  }) : super.dirty(value);
  const AmountFormz.pure({num value = 0}) : lastBalance = 0, super.pure(value);

  final num lastBalance;

  @override
  AmountValidation? validator(num? value) {
    if (value == null || value == 0) return AmountValidation.required;

    if (value > lastBalance) return AmountValidation.minBalance;

    return null;
  }
}

extension AmountFormzX on AmountFormz {
  Color get focusBorderColor {
    return displayError != null ? ColorName.candyRed : ColorName.atenoBlue;
  }

  Color get enableBorderColor {
    return displayError != null ? ColorName.candyRed : ColorName.quickSilver;
  }
}

extension AmountValidationX on AmountValidation {
  String? get message {
    if (this == AmountValidation.required) {
      return 'Nominal tidak boleh kosong';
    }

    if (this == AmountValidation.minBalance) {
      return 'Saldo anda tidak mencukupi untuk penarikan';
    }

    return null;
  }
}
