import 'package:asuka/asuka.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/auth/interfaces/user.dart';
import '../../../../shared/stores/auth_store.dart';
import '../../domain/entities/movie.dart';
import '../../domain/interfaces/movies_repository.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  final IMoviesRepository _repository;
  final AuthStore authStore;
  
  @observable
  int moviesPaginationPage = 1;
  @observable
  ObservableList<Movie> movies = <Movie>[].asObservable();
  @observable
  ObservableList<Movie> favorites = <Movie>[].asObservable();

  HomeControllerBase(this._repository, this.authStore) {
    getFavorites();
  }

  @computed User? get user => authStore.user;

  @action
  Future<void> getPopularMovies() async {
    var response = await _repository.getPopularMovies(
      page: moviesPaginationPage);
    movies.clear();
    response.fold(
      (failure) => AsukaSnackbar.alert(failure.message),
      (r) => movies.addAll(r)
    );
  }

  @action
  Future<void> getFavorites() async {
    var response = await _repository.getFavorites(int.parse(user!.id));
    favorites.clear();
    response.fold(
      (failure) => AsukaSnackbar.alert(failure.message),
      (r) => favorites.addAll(r)
    );
  }

  @action
  Future<void> addFavorite(Movie movie, [bool remove = false]) async {
    await _repository.addFavorite(movie, int.parse(user!.id), remove: remove);
    getFavorites();
  }
}