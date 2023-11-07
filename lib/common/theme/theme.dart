import 'package:corp_devices/common/theme/colors.dart';
import 'package:corp_devices/common/theme/text_styles.dart';
import 'package:corp_devices/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData get darkTheme {
    return ThemeData(
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.black,
      ),
      brightness: Brightness.dark,
      fontFamily: FontFamily.ginto,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.black,
      textTheme: TextThemes.darkTextTheme,
      primaryTextTheme: TextThemes.primaryTextTheme,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.black,
        titleTextStyle: TextStyle(
          color: AppColors.black,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        toolbarHeight: 50,
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.black,
        secondary: AppColors.white,
        background: AppColors.black,
      ).copyWith(background: AppColors.black),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      textTheme: TextThemes.textTheme,
      primaryTextTheme: TextThemes.primaryTextTheme,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        titleTextStyle: TextStyle(
          color: AppColors.black,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: AppColors.white,
      ),
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        background: AppColors.white,
      ).copyWith(background: AppColors.white),
    );
  }
}

class TextThemes {
  static TextTheme get textTheme {
    return const TextTheme(
      bodyLarge: AppTextStyles.bodyLg,
      bodyMedium: AppTextStyles.body,
      titleMedium: AppTextStyles.bodySm,
      titleSmall: AppTextStyles.bodyXs,
      displayLarge: AppTextStyles.h1,
      displayMedium: AppTextStyles.h2,
      displaySmall: AppTextStyles.h3,
      headlineMedium: AppTextStyles.h4,
    );
  }

  static TextTheme get darkTextTheme {
    return TextTheme(
      bodyLarge: AppTextStyles.bodyLg.copyWith(color: AppColors.white),
      bodyMedium: AppTextStyles.body.copyWith(color: AppColors.white),
      titleMedium: AppTextStyles.bodySm.copyWith(color: AppColors.white),
      titleSmall: AppTextStyles.bodyXs.copyWith(color: AppColors.white),
      displayLarge: AppTextStyles.h1.copyWith(color: AppColors.white),
      displayMedium: AppTextStyles.h2.copyWith(color: AppColors.white),
      displaySmall: AppTextStyles.h3.copyWith(color: AppColors.white),
      headlineMedium: AppTextStyles.h4.copyWith(color: AppColors.white),
      headlineSmall: AppTextStyles.h5.copyWith(color: AppColors.white),
    );
  }

  static TextTheme get primaryTextTheme {
    return TextTheme(
      bodyLarge: AppTextStyles.bodyLg.copyWith(color: AppColors.black),
      bodyMedium: AppTextStyles.body.copyWith(color: AppColors.black),
      titleMedium: AppTextStyles.bodySm.copyWith(color: AppColors.black),
      titleSmall: AppTextStyles.bodyXs.copyWith(color: AppColors.black),
      displayLarge: AppTextStyles.h1.copyWith(color: AppColors.black),
      displayMedium: AppTextStyles.h2.copyWith(color: AppColors.black),
      displaySmall: AppTextStyles.h3.copyWith(color: AppColors.black),
      headlineMedium: AppTextStyles.h4.copyWith(color: AppColors.black),
      headlineSmall: AppTextStyles.h5.copyWith(color: AppColors.white),
    );
  }
}
