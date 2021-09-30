
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/errors/errors.dart';
import '../../../../shared/auth/models/user_model.dart';
import '../../domain/repositories/login_interface.dart';
import '../sources/login_data_source.dart';

part 'login_repository.g.dart';

@Injectable()
class LoginRepository implements ILoginRepository {
  final ILoginDataSource dataSource;
  LoginRepository(this.dataSource);

  @override
  Future<Either<Failure, UserModel>> loginEmail({required String email, 
  required String name}) async {
    try {
      var response = await dataSource.login(email, name);
      return Right(UserModel.fromMap(response));
    } catch (e) {
      debugPrint(e.toString());
      return Left(LoginError());
    }
  }

  @override
  Future<Either<Failure, UserModel>> signup(Map<String,dynamic> userData) async {
    try {
      var response = await dataSource.signup(userData['email'],userData['name']);
      return Right(UserModel.fromMap(response));
    } catch (e) {
      debugPrint(e.toString());
      return Left(LoginError());
    }
  }
  
}