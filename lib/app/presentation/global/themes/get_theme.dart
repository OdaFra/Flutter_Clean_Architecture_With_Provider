import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

ThemeData getTheme(bool darkMode) {
  final themeDark = ThemeData.dark();
  final themeLight = ThemeData.light();
  final textTheme = themeLight.textTheme;
  const boldStyle =
      TextStyle(fontWeight: FontWeight.bold, color: AppColors.dark);
  const whiteStyle = TextStyle(color: Colors.white);

  if (darkMode) {
    return themeDark.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.dark,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      textTheme: GoogleFonts.robotoTextTheme(
        textTheme.copyWith(
          titleSmall: textTheme.titleSmall?.merge(whiteStyle),
          titleMedium: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          titleLarge: textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: textTheme.bodySmall?.merge(whiteStyle),
        ),
      ),
      scaffoldBackgroundColor: AppColors.darkLight,
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(Colors.grey.shade600),
        trackColor: WidgetStateProperty.all(Colors.grey.withOpacity(0.2)),
      ),
    );
  }

  const darkStyle = TextStyle(color: AppColors.dark);

  return themeLight.copyWith(
    textTheme: GoogleFonts.robotoTextTheme(
      themeLight.textTheme.copyWith(
          titleSmall: textTheme.titleSmall?.merge(
              boldStyle), //.copyWith(color: AppColors.dark, fontWeight: FontWeight.bold),
          titleMedium: textTheme.titleMedium?.copyWith(
              color: AppColors.dark, fontWeight: FontWeight.bold, fontSize: 18),
          titleLarge: textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: textTheme.bodySmall?.merge(darkStyle)),
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
