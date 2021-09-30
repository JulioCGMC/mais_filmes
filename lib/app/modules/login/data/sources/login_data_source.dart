abstract class ILoginDataSource {
  Future<Map<String,dynamic>> login(String email, String name);
  Future<Map<String,dynamic>> signup(String email, String name);
}