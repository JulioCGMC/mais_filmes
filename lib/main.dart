import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

/// Production configurations
void prdConfig() {
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  debugPrint = (message, {int? wrapWidth}) {};
}
/// Development configurations
void devConfig() {
  FlutterError.onError = FlutterError.dumpErrorToConsole;
  debugPrint = (message, {int? wrapWidth}) => debugPrintSynchronously(
    "[${DateTime.now()}]: $message",
    wrapWidth: wrapWidth
  );
  /// Get current screen Printed
  Modular.to.addListener(() => debugPrint("Gone to: ${Modular.to.path}"));
}

void main() {
  if (kReleaseMode) { prdConfig(); }
  else { devConfig(); }

  WidgetsFlutterBinding.ensureInitialized();
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}