// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FavoritesController on FavoritesControllerBase, Store {
  Computed<ObservableList<Movie>>? _$favoritesComputed;

  @override
  ObservableList<Movie> get favorites => (_$favoritesComputed ??=
          Computed<ObservableList<Movie>>(() => super.favorites,
              name: 'FavoritesControllerBase.favorites'))
      .value;

  @override
  String toString() {
    return '''
favorites: ${favorites}
    ''';
  }
}
