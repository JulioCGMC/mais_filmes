import 'package:flutter_modular/flutter_modular.dart';

import 'data/repositories/login_repository.dart';
import 'external/login_local_data_source.dart';
import 'presentation/controllers/login_controller.dart';
import 'presentation/pages/login_page.dart';
 
class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => LoginController(i.get(),i.get(),i.get())),
    $LoginRepository,
    $LoginLocalDataSource,
  ];

 @override
 final List<ModularRoute> routes = [
   ChildRoute(Modular.initialRoute, child: (_, args) => const LoginPage()),
 ];
}