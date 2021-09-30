import 'dart:convert';

import 'package:mais_filmes/app/modules/home/domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({required int id, required String posterPath, 
    required String releaseDate,
    required String title,
    required num voteAverage,
    required String description
  }) : super(id, posterPath, releaseDate, title, voteAverage, description);
  
  @override
  String get imageUrl => "https://image.tmdb.org/t/p/w220_and_h330_face$posterPath";
  @override
  String get formattedReleaseDate => releaseDate.split('-').reversed.join('/');

  MovieModel copyWith({
    int? id,
    String? posterPath,
    String? releaseDate,
    String? title,
    num? voteAverage,
    String? description
  }) {
    return MovieModel(
      id: id ?? this.id,
      posterPath: posterPath ?? this.posterPath,
      releaseDate: releaseDate ?? this.releaseDate,
      title: title ?? this.title,
      voteAverage: voteAverage ?? this.voteAverage,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'vote_average': voteAverage,
      'overview': description
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'],
      posterPath: map['poster_path'],
      releaseDate: map['release_date'],
      title: map['title'],
      voteAverage: num.parse(map['vote_average'].toString()),
      description: map['overview']
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieModel.fromJson(String source) => MovieModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MovieModel(id: $id, posterPath: $posterPath, releaseDate: $releaseDate, title: $title, voteAverage: $voteAverage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MovieModel &&
      other.id == id &&
      other.posterPath == posterPath &&
      other.releaseDate == releaseDate &&
      other.title == title &&
      other.voteAverage == voteAverage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      posterPath.hashCode ^
      releaseDate.hashCode ^
      title.hashCode ^
      voteAverage.hashCode;
  }
}
