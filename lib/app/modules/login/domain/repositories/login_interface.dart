import '../../../../shared/auth/interfaces/user.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/errors.dart';

abstract class ILoginRepository {
  Future<Either<Failure, User>> signup(Map<String,dynamic> userData);
  Future<Either<Failure, User>> loginEmail(
    {required String email, required String name});
}
