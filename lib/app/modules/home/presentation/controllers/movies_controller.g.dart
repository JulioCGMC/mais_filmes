// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MoviesController on MoviesControllerBase, Store {
  Computed<ObservableList<Movie>>? _$moviesComputed;

  @override
  ObservableList<Movie> get movies =>
      (_$moviesComputed ??= Computed<ObservableList<Movie>>(() => super.movies,
              name: 'MoviesControllerBase.movies'))
          .value;
  Computed<ObservableList<Movie>>? _$favoritesComputed;

  @override
  ObservableList<Movie> get favorites => (_$favoritesComputed ??=
          Computed<ObservableList<Movie>>(() => super.favorites,
              name: 'MoviesControllerBase.favorites'))
      .value;

  final _$changeMoviesPageAsyncAction =
      AsyncAction('MoviesControllerBase.changeMoviesPage');

  @override
  Future<void> changeMoviesPage([int page = 0]) {
    return _$changeMoviesPageAsyncAction
        .run(() => super.changeMoviesPage(page));
  }

  @override
  String toString() {
    return '''
movies: ${movies},
favorites: ${favorites}
    ''';
  }
}
