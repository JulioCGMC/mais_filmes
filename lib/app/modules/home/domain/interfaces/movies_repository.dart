import 'package:dartz/dartz.dart';
import 'package:mais_filmes/app/core/errors/errors.dart';
import 'package:mais_filmes/app/modules/home/domain/entities/movie.dart';

abstract class IMoviesRepository {
  Future<Either<Failure,List<Movie>>> getPopularMovies({int page = 0});
  Future<Either<Failure,Movie>> getMovieDetails(int id);
  Future<Either<Failure,List<Movie>>> getFavorites(int userId);
  Future<void> addFavorite(Movie movie, int userId, 
    {bool remove = false});
}