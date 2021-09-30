import 'package:flutter_modular/flutter_modular.dart';
import 'package:mais_filmes/app/shared/sqlite/interfaces/sqlite_driver.dart';
import '../data/sources/login_data_source.dart';

part 'login_local_data_source.g.dart';

@Injectable()
class LoginLocalDataSource implements ILoginDataSource {
  final ISqliteDriver sqliteDriver;
  final String userTable = 'user';

  LoginLocalDataSource(this.sqliteDriver);

  @override
  Future<Map<String, dynamic>> login(String email, String name) async {
    return await sqliteDriver.get(userTable, 
      where: 'email = ? AND name = ?',
      whereArgs: [email, name]
    );
  }

  @override
  Future<Map<String, dynamic>> signup(String email, String name) async {
    Map<String, Object?> values = {'email': email, 'name': name};
    values['id'] = await sqliteDriver.insert(userTable, values);
    return values;
  }
  
}