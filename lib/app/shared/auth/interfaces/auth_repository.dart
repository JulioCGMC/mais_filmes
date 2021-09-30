import 'user.dart';

abstract class IAuthRepository {
  Future<User?> getUser();
  Future<void> setUser(User user);
  Future<void> logOut();
}