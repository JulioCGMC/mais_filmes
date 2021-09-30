import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/errors/errors.dart';
import '../../../../shared/network/interfaces/connectivity_interface.dart';
import '../../domain/entities/movie.dart';
import '../../domain/interfaces/movies_repository.dart';
import '../models/movie_model.dart';
import '../sources/movies_data_source.dart';

part 'movies_repository.g.dart';

@Injectable()
class MoviesRepository implements IMoviesRepository {
  final IMoviesDataSource dataSource;
  final IConnectivityDriver _connectivityDriver;

  MoviesRepository(this.dataSource, this._connectivityDriver);

  @override
  Future<Either<Failure, Movie>> getMovieDetails(int id) async {
    if (!(await _connectivityDriver.isOnline)) {
      return Left(ConnectionError());
    }
    try {
      var response = await dataSource.getMovieDetails(id);
      return Right(MovieModel.fromMap(response));
    } catch (e) {
      debugPrint(e.toString());
      return Left(InternalError());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies({int page = 0}) async {
    if (!(await _connectivityDriver.isOnline)) {
      return Left(ConnectionError());
    }
    try {
      List<MovieModel> movies = [];
      var response = await dataSource.popular(page);
      for (var map in response) {
        movies.add(MovieModel.fromMap(map));
      }
      return Right(movies);
    } catch (e) {
      debugPrint(e.toString());
      return Left(InternalError());
    }
  }

  @override
  Future<Either<Failure,List<Movie>>> getFavorites(int userId) async {
    try {
      List<MovieModel> movies = [];
      var response = await dataSource.favorites(userId);
      for (var map in response) {
        movies.add(MovieModel.fromMap(map));
      }
      return Right(movies);
    } catch (e) {
      debugPrint(e.toString());
      return Left(InternalError());
    }
  }

  @override
  Future<void> addFavorite(Movie movie, int userId, 
  {bool remove = false}) async {
    try {
      if (remove) {
        await dataSource.removeFavorite(movie.id, userId);
      }
      else {
        Map<String,dynamic> data = movie.toMap();
        data['user_id'] = userId;
        await dataSource.addFavorite(data);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  
}