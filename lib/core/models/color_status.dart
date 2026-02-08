import 'package:flutter/widgets.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

enum ColorStatus { init, success, info, danger, warning }

extension BadgeStatusX on ColorStatus {
  Color get color {
    switch (this) {
      case ColorStatus.init:
        return ColorName.romanSilver;
      case ColorStatus.warning:
        return ColorName.orange;
      case ColorStatus.success:
        return ColorName.greenSalem;
      case ColorStatus.info:
        return ColorName.ultramarineBlue;
      case ColorStatus.danger:
        return ColorName.candyRed;
    }
  }
}
