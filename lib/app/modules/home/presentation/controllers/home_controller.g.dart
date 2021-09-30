// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on HomeControllerBase, Store {
  Computed<User?>? _$userComputed;

  @override
  User? get user => (_$userComputed ??=
          Computed<User?>(() => super.user, name: 'HomeControllerBase.user'))
      .value;

  final _$moviesPaginationPageAtom =
      Atom(name: 'HomeControllerBase.moviesPaginationPage');

  @override
  int get moviesPaginationPage {
    _$moviesPaginationPageAtom.reportRead();
    return super.moviesPaginationPage;
  }

  @override
  set moviesPaginationPage(int value) {
    _$moviesPaginationPageAtom.reportWrite(value, super.moviesPaginationPage,
        () {
      super.moviesPaginationPage = value;
    });
  }

  final _$moviesAtom = Atom(name: 'HomeControllerBase.movies');

  @override
  ObservableList<Movie> get movies {
    _$moviesAtom.reportRead();
    return super.movies;
  }

  @override
  set movies(ObservableList<Movie> value) {
    _$moviesAtom.reportWrite(value, super.movies, () {
      super.movies = value;
    });
  }

  final _$favoritesAtom = Atom(name: 'HomeControllerBase.favorites');

  @override
  ObservableList<Movie> get favorites {
    _$favoritesAtom.reportRead();
    return super.favorites;
  }

  @override
  set favorites(ObservableList<Movie> value) {
    _$favoritesAtom.reportWrite(value, super.favorites, () {
      super.favorites = value;
    });
  }

  final _$getPopularMoviesAsyncAction =
      AsyncAction('HomeControllerBase.getPopularMovies');

  @override
  Future<void> getPopularMovies() {
    return _$getPopularMoviesAsyncAction.run(() => super.getPopularMovies());
  }

  final _$getFavoritesAsyncAction =
      AsyncAction('HomeControllerBase.getFavorites');

  @override
  Future<void> getFavorites() {
    return _$getFavoritesAsyncAction.run(() => super.getFavorites());
  }

  final _$addFavoriteAsyncAction =
      AsyncAction('HomeControllerBase.addFavorite');

  @override
  Future<void> addFavorite(Movie movie, [bool remove = false]) {
    return _$addFavoriteAsyncAction.run(() => super.addFavorite(movie, remove));
  }

  @override
  String toString() {
    return '''
moviesPaginationPage: ${moviesPaginationPage},
movies: ${movies},
favorites: ${favorites},
user: ${user}
    ''';
  }
}
