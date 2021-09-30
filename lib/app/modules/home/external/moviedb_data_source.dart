import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mais_filmes/app/core/constants/apis.dart';
import 'package:mais_filmes/app/modules/home/data/sources/movies_data_source.dart';
import 'package:mais_filmes/app/shared/sqlite/interfaces/sqlite_driver.dart';

part 'moviedb_data_source.g.dart';

@Injectable()
class MoviedbDataSource implements IMoviesDataSource {
  final Dio _dio;
  final ISqliteDriver sqliteDriver;
  final String favoriteTable = 'favorite';
  
  MoviedbDataSource(this._dio,this.sqliteDriver);

  @override
  Future<Map<String, dynamic>> getMovieDetails(int id) async {
    Map<String,dynamic> queryParameters = {
      "api_key": Apis.moviedbApiKey,
      "language": "pt-BR"
    };
    var response = await _dio.get("${Apis.baseMoviedbUrl}/$id", 
      queryParameters: queryParameters);
    return response.data;
  }

  @override
  Future<List<Map<String, dynamic>>> popular(int page) async {
    Map<String,dynamic> queryParameters = {
      "page": page,
      "api_key": Apis.moviedbApiKey,
      "language": "pt-BR"
    };
    var response = await _dio.get("${Apis.baseMoviedbUrl}/popular", 
      queryParameters: queryParameters);
    var data = response.data['results'];
    return data.cast<Map<String,dynamic>>();
  }

  @override
  Future<List<Map<String, dynamic>>> favorites(int userId) async {
    return await sqliteDriver.select(favoriteTable, 
      where: 'user_id = ?',
      whereArgs: [userId]
    );
  }

  @override
  Future<void> addFavorite(Map<String, dynamic> movieData) async {
    await sqliteDriver.insert(favoriteTable, movieData);
  }

  @override
  Future<void> removeFavorite(int id, int userId) async {
    await sqliteDriver.delete(favoriteTable, 
      where: 'id = $id AND user_id = $userId');
  }
  
}