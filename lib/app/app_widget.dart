import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:asuka/asuka.dart' as asuka;

import 'core/constants/custom_text_theme.dart';
import 'core/constants/default_style.dart';
import 'core/constants/metadata.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Metadata.appName,
      theme: ThemeData.from(
        colorScheme: DefaultStyle.light, 
        textTheme: CustomTextTheme.light
      ),
      darkTheme: ThemeData.from(
        colorScheme: DefaultStyle.dark,
        textTheme: CustomTextTheme.dark
      ),
      themeMode: ThemeMode.dark,
      initialRoute: '/',
      builder: asuka.builder,
      navigatorObservers: [
        // if u don`t add this Hero will not work
        asuka.asukaHeroController
      ],
    ).modular();
  }
}