import '../../shared/stores/auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthGuard extends RouteGuard { 
  AuthGuard() : super(redirectTo: '/login');

  @override
  Future<bool> canActivate(String path, ParallelRoute route) async {
    return await Modular.get<AuthStore>().isLogged;
  }
}