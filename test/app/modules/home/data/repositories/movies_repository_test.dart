@Tags(['repositories'])

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mais_filmes/app/core/errors/errors.dart';
import 'package:mais_filmes/app/modules/home/data/models/movie_model.dart';
import 'package:mais_filmes/app/modules/home/data/repositories/movies_repository.dart';
import 'package:mais_filmes/app/modules/home/data/sources/movies_data_source.dart';
import 'package:mais_filmes/app/shared/network/interfaces/connectivity_interface.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixture_reader.dart';
import 'movies_repository_test.mocks.dart';

@GenerateMocks([IMoviesDataSource, IConnectivityDriver])
void main() {
  late final MoviesRepository repository;
  late final IMoviesDataSource mockDataSource;
  late final IConnectivityDriver mockDriver;

  setUpAll(() {
    mockDataSource = MockIMoviesDataSource();
    mockDriver = MockIConnectivityDriver();
    repository = MoviesRepository(mockDataSource, mockDriver);
  });

  group("Testes de sucesso:", () {
    setUp(() {
      when(mockDriver.isOnline).thenAnswer((_) async => true);
    });
    test("Deveria pegar uma lista com filmes populares", () async {
      // Arrange
        final Map<String, dynamic> map = json.decode(fixture("movie_list.json"));
        final List<MovieModel> movies = map['results'].map<MovieModel>((e) 
          => MovieModel.fromMap(e)).toList();
        when(mockDataSource.popular(2)).thenAnswer((_) async 
          => map['results'].cast<Map<String,dynamic>>());
      // Act
        var response = await repository.getPopularMovies(page: 2);
      // Assert
        verify(mockDataSource.popular(2));
        expect(response, isA<Right>());
        expect(response.fold(id, id), equals(movies));
    });

    test("Deveria pegar um filme pelo id", () async {
      // Arrange
        final Map<String, dynamic> map = json.decode(fixture("movie.json"));
        final MovieModel movie = MovieModel.fromMap(map);
        when(mockDataSource.getMovieDetails(550)).thenAnswer((_) async 
          => map);
      // Act
        var response = await repository.getMovieDetails(550);
      // Assert
        verify(mockDataSource.getMovieDetails(550));
        expect(response, isA<Right>());
        expect(response.fold(id, id), equals(movie));
    });
  });

  group("Testes de falha:", () {
    test("Deveria retornar erro por conexão ao buscar filmes populares", () async {
      // Arrange
        when(mockDriver.isOnline).thenAnswer((_) async 
          => false);
      // Act
        var response = await repository.getPopularMovies(page: 2);
      // Assert
        expect(response, isA<Left>());
        expect(response.fold(id, id), isA<ConnectionError>());
    });

    test("Deveria retornar erro por conexão ao buscar um filme por id", () async {
      // Arrange
        when(mockDriver.isOnline).thenAnswer((_) async 
          => false);
      // Act
        var response = await repository.getMovieDetails(550);
      // Assert
        expect(response, isA<Left>());
        expect(response.fold(id, id), isA<ConnectionError>());
    });
    
    test("Deveria retornar erro interno ao buscar filmes populares", () async {
      // Arrange
        when(mockDriver.isOnline).thenAnswer((_) async 
          => true);
        when(mockDataSource.popular(2)).thenThrow(Exception());
      // Act
        var response = await repository.getPopularMovies(page: 2);
      // Assert
        verify(mockDataSource.popular(2));
        expect(response, isA<Left>());
        expect(response.fold(id, id), isA<InternalError>());
    });

    test("Deveria retornar erro interno ao buscar um filme por id", () async {
      // Arrange
        when(mockDriver.isOnline).thenAnswer((_) async 
          => true);
        when(mockDataSource.getMovieDetails(550)).thenThrow(Exception());
      // Act
        var response = await repository.getMovieDetails(550);
      // Assert
        verify(mockDataSource.getMovieDetails(550));
        expect(response, isA<Left>());
        expect(response.fold(id, id), isA<InternalError>());
    });
    
  });
}