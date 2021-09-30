import 'package:flutter_modular/flutter_modular.dart';
import '../interfaces/auth_data_source.dart';
import '../../../shared/local_storage/interfaces/local_storage_driver.dart';

part 'auth_local_data_source.g.dart';

@Injectable()
class AuthLocalDataSource implements IAuthDataSource {
  final ILocalStorageDriver localStorage;
  final String userKey = "local_user";

  AuthLocalDataSource(this.localStorage);

  @override
  Future<Map<String, dynamic>> getUser() async {
    return Map<String,dynamic>.from(await localStorage.get(userKey));
  }

  @override
  Future<void> setUser(Map<String, dynamic> data) async {
    return await localStorage.put(userKey, data);
  }

  @override
  Future<void> logOut() async {
    return await localStorage.delete(userKey);
  }
  
}