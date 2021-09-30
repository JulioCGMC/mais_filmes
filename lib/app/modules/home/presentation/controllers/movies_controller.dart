import 'package:mobx/mobx.dart';

import '../../domain/entities/movie.dart';
import 'home_controller.dart';

part 'movies_controller.g.dart';

class MoviesController = MoviesControllerBase with _$MoviesController;

abstract class MoviesControllerBase with Store {
  final HomeController baseController;

  MoviesControllerBase(this.baseController) {
    if (movies.isEmpty) {
      changeMoviesPage();
    }
  }

  @computed
  ObservableList<Movie> get movies => baseController.movies;
  @computed
  ObservableList<Movie> get favorites => baseController.favorites;

  @action Future<void> changeMoviesPage([int page = 0]) async {
    if (baseController.moviesPaginationPage + page > 0) {
      baseController.moviesPaginationPage += page;
      
      baseController.getPopularMovies();
    }
  }
}