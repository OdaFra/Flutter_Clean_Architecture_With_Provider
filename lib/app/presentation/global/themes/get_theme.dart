import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

ThemeData getTheme(bool darkMode) {
  final themeDark = ThemeData.dark();
  final themeLight = ThemeData.light();
  if (darkMode) {
    return themeDark.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.dark,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      textTheme: GoogleFonts.robotoTextTheme(themeDark.textTheme),
      scaffoldBackgroundColor: AppColors.darkLight,
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(Colors.grey.shade600),
        trackColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.2)),
      ),
    );
  }
  return themeLight.copyWith(
    textTheme: GoogleFonts.robotoTextTheme(
      themeLight.textTheme.copyWith(
        bodyMedium: const TextStyle(color: AppColors.dark),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.dark,
      ),
      titleTextStyle: TextStyle(
        color: AppColors.dark,
      ),
    ),
    tabBarTheme: const TabBarTheme(labelColor: AppColors.dark),
  );
}
