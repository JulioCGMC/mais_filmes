abstract class IAuthDataSource {
  Future<Map<String,dynamic>> getUser();
  Future<void> setUser(Map<String,dynamic> data);
  Future<void> logOut();
}