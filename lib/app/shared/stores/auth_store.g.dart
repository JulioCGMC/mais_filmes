// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $AuthStore = BindInject(
  (i) => AuthStore(i<IAuthRepository>()),
  isSingleton: true,
  isLazy: false,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStoreBase, Store {
  final _$userAtom = Atom(name: '_AuthStoreBase.user');

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$getLoggedUserAsyncAction =
      AsyncAction('_AuthStoreBase.getLoggedUser');

  @override
  Future<void> getLoggedUser() {
    return _$getLoggedUserAsyncAction.run(() => super.getLoggedUser());
  }

  final _$setLoggedUserAsyncAction =
      AsyncAction('_AuthStoreBase.setLoggedUser');

  @override
  Future<void> setLoggedUser(User? value) {
    return _$setLoggedUserAsyncAction.run(() => super.setLoggedUser(value));
  }

  @override
  String toString() {
    return '''
user: ${user}
    ''';
  }
}
