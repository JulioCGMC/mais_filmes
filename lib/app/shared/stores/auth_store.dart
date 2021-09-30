import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/constants/metadata.dart';
import '../auth/interfaces/auth_repository.dart';
import '../auth/interfaces/user.dart';

part 'auth_store.g.dart';

// We disable the lazy, so the class will be called as soon as the module starts
// Instead of calling only when is needed for the first time
@Injectable(lazy: false)
class AuthStore = _AuthStoreBase with _$AuthStore;
abstract class _AuthStoreBase with Store {
  final IAuthRepository _repository;
  _AuthStoreBase(this._repository) {
    getLoggedUser();
  }

  @observable
  User? user;

  @action
  Future<void> getLoggedUser() async {
    await setLoggedUser(await _repository.getUser());
  }

  @action
  Future<void> setLoggedUser(User? value) async {
    user = value;
    if (user != null && !Modular.to.path.startsWith(Metadata.loggedRoute)) {
      _repository.setUser(user!);
      Modular.to.navigate(Metadata.loggedRoute);
    }
  }

  FutureOr<bool> get isLogged async {
    if (user != null) {
      return true;
    } else {
      await getLoggedUser();
      return (user != null);
    }
  }

  Future<void> logOut() async {
    await _repository.logOut();
    if (!Modular.to.path.startsWith(Metadata.unloggedRoute)) {
      Modular.to.navigate(Metadata.unloggedRoute);
    }
  }
}