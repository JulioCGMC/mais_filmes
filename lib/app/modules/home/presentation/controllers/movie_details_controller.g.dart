// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MovieDetailsController on MovieDetailsControllerBase, Store {
  Computed<User?>? _$userComputed;

  @override
  User? get user => (_$userComputed ??= Computed<User?>(() => super.user,
          name: 'MovieDetailsControllerBase.user'))
      .value;

  final _$favoritesAtom = Atom(name: 'MovieDetailsControllerBase.favorites');

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

  final _$getFavoritesAsyncAction =
      AsyncAction('MovieDetailsControllerBase.getFavorites');

  @override
  Future<void> getFavorites() {
    return _$getFavoritesAsyncAction.run(() => super.getFavorites());
  }

  final _$addFavoriteAsyncAction =
      AsyncAction('MovieDetailsControllerBase.addFavorite');

  @override
  Future<void> addFavorite(Movie movie, [bool remove = false]) {
    return _$addFavoriteAsyncAction.run(() => super.addFavorite(movie, remove));
  }

  @override
  String toString() {
    return '''
favorites: ${favorites},
user: ${user}
    ''';
  }
}
