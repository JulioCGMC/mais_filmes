import 'package:flutter_modular/flutter_modular.dart';
import 'package:mais_filmes/app/shared/auth/interfaces/user.dart';

import '../interfaces/auth_data_source.dart';
import '../interfaces/auth_repository.dart';
import '../models/user_model.dart';

part 'auth_repository.g.dart';

@Injectable(lazy: false)
class AuthRepository implements IAuthRepository {
  final IAuthDataSource _dataSource;
  AuthRepository(this._dataSource);

  @override
  Future<UserModel?> getUser() async {
    try {
      return UserModel.fromMap(await _dataSource.getUser());
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> setUser(User user) async {
    _dataSource.setUser(user.toMap());
  }

  @override
  Future<void> logOut() async => _dataSource.logOut();

}