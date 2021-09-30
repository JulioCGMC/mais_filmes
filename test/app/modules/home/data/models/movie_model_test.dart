@Tags(['models'])

import 'dart:convert';

import 'package:mais_filmes/app/modules/home/data/models/movie_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mais_filmes/app/modules/home/domain/entities/movie.dart';

void main() {
  final Map<String,dynamic> expectedMap = {"id": 550,
    "poster_path": "/m83Uwna5ohsLchpacgU3j8EtGhG.jpg","release_date": "1999-10-15",
    "title": "Clube da Luta", "vote_average": 8.4
  };
  final expectedMovieModel = MovieModel(id: expectedMap['id'],
    title: expectedMap['title'], releaseDate: expectedMap['release_date'],
    posterPath: expectedMap['poster_path'], voteAverage: expectedMap['vote_average']
  );

  group("MovieModel:", () {
    test("MovieModel deveria ser herdeira da entidade Movie", () async {
      /// Assert
      expect(expectedMovieModel, isA<Movie>());
    });

    test("Deveria retornar um model válido para uma única localização", () async {
      /// Act
      final result = MovieModel.fromJson(json.encode(expectedMap));
      /// Assert
      expect(result, isA<Movie>());
    });
    test("Deveria verificar se o retorno é um Json", () async {
      /// Act
      final resultJson = expectedMovieModel.toJson();
      final resultMap = expectedMovieModel.toMap();
      /// Assert
      expect(resultMap, expectedMap);
      expect(resultJson, json.encode(expectedMap));
    });
  });
}