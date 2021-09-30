@Tags(['data_sources'])

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mais_filmes/app/core/constants/apis.dart';
import 'package:mais_filmes/app/modules/home/external/moviedb_data_source.dart';
import 'package:mais_filmes/app/shared/sqlite/interfaces/sqlite_driver.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

import 'moviedb_data_source_test.mocks.dart';

@GenerateMocks([Dio, ISqliteDriver])
void main() {
  late final MoviedbDataSource dataSource;
  late final Dio mockDio;
  late final ISqliteDriver mockDriver;

  setUpAll(() {
    mockDio = MockDio();
    mockDriver = MockISqliteDriver();
    dataSource = MoviedbDataSource(mockDio, mockDriver);
  });

  group("Testes de sucesso:", () {
    test("Deveria pegar um filme pelo id", () async {
      // Arrange
        final Map<String, dynamic> map = json.decode(fixture("movie.json"));
        when(mockDio.get("${Apis.baseMoviedbUrl}/550",
          queryParameters: anyNamed('queryParameters'))).thenAnswer((_) async 
            => Response(data: map, 
            requestOptions: RequestOptions(path: "${Apis.baseMoviedbUrl}/550")
          ));
      // Act
        var response = await dataSource.getMovieDetails(550);
      // Assert
        verify(mockDio.get("${Apis.baseMoviedbUrl}/550",
          queryParameters: anyNamed('queryParameters')));
        expect(response, equals(map));
    });

    test("Deveria pegar uma lista com filmes populares", () async {
      // Arrange
        final Map<String, dynamic> map = json.decode(fixture("movie_list.json"));
        when(mockDio.get("${Apis.baseMoviedbUrl}/popular",
          queryParameters: anyNamed('queryParameters'))).thenAnswer((_) async 
            => Response(data: map, 
            requestOptions: RequestOptions(path: "${Apis.baseMoviedbUrl}/popular")
          ));
      // Act
        var response = await dataSource.popular(2);
      // Assert
        verify(mockDio.get("${Apis.baseMoviedbUrl}/popular",
          queryParameters: anyNamed('queryParameters')));
        expect(response, equals(map['results'].cast<Map<String,dynamic>>()));
    });
  });

  group("Testes de falha:", () {
    test("Deveria retornar um erro falha na requisição", () async {
      // Arrange
        when(mockDio.get("${Apis.baseMoviedbUrl}/550",
          queryParameters: anyNamed('queryParameters')
        )).thenThrow(Exception());
      // Assert
        expect(() async => await dataSource.getMovieDetails(550), throwsException);
    });
  });
}