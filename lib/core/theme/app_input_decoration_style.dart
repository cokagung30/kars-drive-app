import 'package:flutter/material.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';
import 'package:kars_driver_app/gen/fonts.gen.dart';

abstract class AppInputDecorationStyle {
  static const normal = InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    fillColor: Colors.white,
    hintStyle: TextStyle(
      fontSize: 12,
      color: ColorName.darkJungleBlue,
      fontWeight: FontWeight.w400,
      fontFamily: FontFamily.poppins,
      letterSpacing: -0.1,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: ColorName.atenoBlue),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: ColorName.quickSilver),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: ColorName.atenoBlue),
    ),
    errorStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: FontFamily.poppins,
      color: ColorName.candyRed,
      package: 'ui',
    ),
  );

  static const outline = InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    hintStyle: TextStyle(
      fontSize: 12,
      color: ColorName.darkJungleBlue,
      fontWeight: FontWeight.w400,
      fontFamily: FontFamily.poppins,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: ColorName.quickSilver),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: ColorName.quickSilver),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: ColorName.atenoBlue),
    ),
    errorStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: FontFamily.poppins,
      color: ColorName.candyRed,
      package: 'ui',
    ),
  );
}
