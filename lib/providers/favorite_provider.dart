import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../services/db_service.dart';

class FavoriteProvider with ChangeNotifier {
  List<Movie> _favorites = [];
  DatabaseHelper _dbHelper = DatabaseHelper();

  List<Movie> get favorites => _favorites;

  Future<void> loadFavorites() async {
    _favorites = await _dbHelper.getFavoriteMovies();
    notifyListeners();
  }

  Future<List<Movie>> getFavoriteMovies() async {
    return _favorites;
  }

  Future<void> addFavorite(Movie movie) async {
    await _dbHelper.insertMovie(movie);
    _favorites.add(movie);
    notifyListeners();
  }

  Future<void> removeFavorite(int id) async {
    await _dbHelper.deleteMovie(id);
    _favorites.removeWhere((movie) => movie.id == id);
    notifyListeners();
  }

  Future<bool> isFavorite(int id) async {
    return await _dbHelper.isFavorite(id);
  }
}
