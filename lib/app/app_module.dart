import 'package:flutter_modular/flutter_modular.dart';
import 'package:mais_filmes/app/shared/auth/sources/auth_local_data_source.dart';
import 'package:mais_filmes/app/shared/sqlite/drivers/sqlite_sqflite_driver.dart';

import 'core/guards/auth_guard.dart';
import 'core/pages/error_page.dart';
import 'core/pages/splash_page.dart';
import 'modules/home/home_module.dart';
import 'modules/login/login_module.dart';
import 'shared/auth/repositories/auth_repository.dart';
import 'shared/network/drivers/connectivity_driver.dart';
import 'shared/overlay/loading_dialog.dart';
import 'shared/stores/auth_store.dart';
import 'shared/local_storage/drivers/local_storage_hive_driver.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    $AuthStore,
    $AuthRepository,
    $AuthLocalDataSource,
    $LoadingDialogImpl,
    Bind.lazySingleton((i) => SqliteSqfliteDriver()),
    Bind.lazySingleton((i) => LocalStorageHiveDriver()),
    $ConnectivityDriver
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => SplashScreenPage()),
    ModuleRoute('/home', module: HomeModule(), guards: [AuthGuard()]),
    ModuleRoute('/login', module: LoginModule()),
    WildcardRoute(
        child: (_, __) => const ErrorPage("Página não encontrada", null))
  ];
}
