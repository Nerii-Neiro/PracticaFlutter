
import 'package:flutter/material.dart';
import 'package:testw/models/popular_model.dart';

class FavoritesProvider with ChangeNotifier {
  final List<PopularModel> _favorites = [];

  List<PopularModel> get favorites => _favorites;

  void toggleFavorite(PopularModel movie) {
    if (_favorites.any((m) => m.id == movie.id)) {
      _favorites.removeWhere((m) => m.id == movie.id);
    } else {
      _favorites.add(movie);
    }
    notifyListeners();
  }

  bool isFavorite(PopularModel movie) {
    return _favorites.any((m) => m.id == movie.id);
  }

  void removeFavorite(PopularModel movie) {
    _favorites.removeWhere((m) => m.id == movie.id);
    notifyListeners();
  }
}
