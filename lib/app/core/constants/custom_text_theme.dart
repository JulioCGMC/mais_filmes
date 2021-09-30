import 'package:flutter/material.dart';

class CustomTextTheme {
  // final MaterialColor swatch = 
  static const LightTextTheme light = LightTextTheme();
  static const DarkTextTheme dark = DarkTextTheme();

  static TextTheme currentTheme(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    if (isDarkMode) return dark;
    return light;
  }
}

class LightTextTheme extends TextTheme {

  const LightTextTheme(

  ) : super();
}

class DarkTextTheme extends TextTheme {

  const DarkTextTheme(
    
  ) : super();
}
