import 'package:flutter/material.dart';

ThemeData getTheme(bool darkMode) {
  if (darkMode) {
    return ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.grey);
  }
  return ThemeData.light();
}
