import 'package:flutter/material.dart';
import 'package:kars_driver_app/core/theme/theme.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';
import 'package:kars_driver_app/gen/fonts.gen.dart';

class AppTheme {
  static ThemeData get standard {
    return ThemeData(
      textTheme: _textTheme,
      primaryColor: ColorName.atenoBlue,
      brightness: Brightness.light,
      inputDecorationTheme: AppInputDecorationStyle.outline,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: ColorName.atenoBlue,
        secondary: ColorName.cultured,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: AppButtonStyle.outlined,
      ),
      textButtonTheme: TextButtonThemeData(
        style: AppButtonStyle.text,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: AppButtonStyle.elevated,
      ),
      scaffoldBackgroundColor: ColorName.white,
      tabBarTheme: const TabBarThemeData(
        labelColor: ColorName.darkJungleBlue,
        unselectedLabelColor: ColorName.quickSilver,
        labelStyle: TextStyle(
          fontSize: 14,
          color: ColorName.darkJungleBlue,
          fontWeight: FontWeight.w600,
          fontFamily: FontFamily.poppins,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          color: ColorName.quickSilver,
          fontWeight: FontWeight.w600,
          fontFamily: FontFamily.poppins,
        ),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: ColorName.darkJungleBlue,
            width: 2,
          ),
        ),
      ),
    );
  }

  static TextTheme get _textTheme {
    return const TextTheme(
      titleLarge: AppTextStyle.titleSemibold,
      titleMedium: AppTextStyle.titleMedium,
      titleSmall: AppTextStyle.titleRegular,
      headlineLarge: AppTextStyle.largeSemibold,
      headlineMedium: AppTextStyle.largeMedium,
      headlineSmall: AppTextStyle.largeRegular,
      bodyLarge: AppTextStyle.bodySemibold,
      bodyMedium: AppTextStyle.bodyMedium,
      bodySmall: AppTextStyle.bodyRegular,
      labelLarge: AppTextStyle.captionSemibold,
      labelMedium: AppTextStyle.captionMedium,
      labelSmall: AppTextStyle.captionRegular,
    );
  }
}
