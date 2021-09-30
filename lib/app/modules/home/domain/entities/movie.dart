abstract class Movie {
  int id;
  String title;
  String description;
  String posterPath;
  String backdropPath;
  String releaseDate;
  num voteAverage;

  Movie(this.id, this.posterPath, this.backdropPath, this.releaseDate, this.title, this.voteAverage, this.description);

  String get posterUrl;
  String get coverUrl;
  String get formattedReleaseDate;

  Map<String,dynamic> toMap();
}