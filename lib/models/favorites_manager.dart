class FavoritesManager {
  static final FavoritesManager _instance = FavoritesManager._internal();
  factory FavoritesManager() => _instance;
  FavoritesManager._internal();

  final Set<int> _favoriteMovieIds = {};

  bool isFavorite(int movieId) => _favoriteMovieIds.contains(movieId);

  void addFavorite(int movieId) {
    _favoriteMovieIds.add(movieId);
  }

  void removeFavorite(int movieId) {
    _favoriteMovieIds.remove(movieId);
  }

  List<int> get favorites => _favoriteMovieIds.toList();
}
