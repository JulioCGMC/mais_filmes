import 'package:flutter/material.dart';

class DefaultStyle {
  static const LightTheme light = LightTheme();
  static const DarkTheme dark = DarkTheme();

  static ColorScheme currentTheme(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    if (isDarkMode) return dark;
    return light;
  }

  static isDarkMode(BuildContext context)
    => Theme.of(context).brightness == Brightness.dark;
}

class LightTheme extends ColorScheme {
  const LightTheme({
    primary = const Color(0xFF87BD44),
    primaryVariant = const Color(0xFF4B9A3F),
    secondary = const Color(0xFFEEE217),
    secondaryVariant = const Color(0xFFCAD64C),
    surface = const Color(0xFFF1F2F3),
    background = const Color(0xFFFFFFFF),
    error = const Color(0xFFED4954),
    onPrimary = Colors.white,
    onSecondary = Colors.white,
    onSurface = Colors.black45,
    onBackground = Colors.black,
    onError = Colors.white,
    brightness = Brightness.light
  }) : super(
    primary: primary,
    primaryVariant: primaryVariant,
    secondary: secondary,
    secondaryVariant: secondaryVariant,
    surface: surface,
    background: background,
    error: error,
    onPrimary: onPrimary,
    onSecondary: onSecondary,
    onSurface: onSurface,
    onBackground: onBackground,
    onError: onError,
    brightness: brightness,
  );
}

class DarkTheme extends ColorScheme {
  const DarkTheme({
    primary = const Color(0xFFAA7BE5),
    primaryVariant = const Color(0xFF772AD5),
    secondary = const Color(0xFF60DBC6),
    secondaryVariant = const Color(0xFF2FD0B5),
    surface = const Color(0xFF3C3E44),
    background = const Color(0xFF24282F),
    error = const Color(0xFFED4954),
    onPrimary = Colors.black,
    onSecondary = Colors.black,
    onSurface = Colors.white70,
    onBackground = Colors.white,
    onError = Colors.white,
    brightness = Brightness.dark,
  }) : super(
    primary: primary,
    primaryVariant: primaryVariant,
    secondary: secondary,
    secondaryVariant: secondaryVariant,
    surface: surface,
    background: background,
    error: error,
    onPrimary: onPrimary,
    onSecondary: onSecondary,
    onSurface: onSurface,
    onBackground: onBackground,
    onError: onError,
    brightness: brightness,
  );
}
