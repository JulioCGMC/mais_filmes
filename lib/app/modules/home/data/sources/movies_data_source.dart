abstract class IMoviesDataSource {
  Future<List<Map<String,dynamic>>> popular(int page);
  Future<List<Map<String,dynamic>>> favorites(int userId);
  Future<void> addFavorite(Map<String,dynamic> movieData);
  Future<void> removeFavorite(int id, int userId);
  Future<Map<String,dynamic>> getMovieDetails(int id);
}