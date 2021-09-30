abstract class Movie {
  int id;
  String title;
  String description;
  String posterPath;
  String releaseDate;
  num voteAverage;

  Movie(this.id, this.posterPath, this.releaseDate, this.title, this.voteAverage, this.description);

  String get imageUrl;
  String get formattedReleaseDate;

  Map<String,dynamic> toMap();
}