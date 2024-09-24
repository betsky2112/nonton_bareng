import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../services/api_service.dart';

class MovieProvider with ChangeNotifier {
  // Popular Movies
  List<Movie> _popularMovies = [];
  bool _isLoading = false;

  List<Movie> get popularMovies => _popularMovies;
  bool get isLoading => _isLoading;

  Future<void> fetchPopularMovies() async {
    _isLoading = true;
    notifyListeners();

    try {
      _popularMovies = await ApiService().fetchPopularMovies();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //Search Movies
  List<Movie> _searchResults = [];
  bool _isSearching = false;

  List<Movie> get searchResults => _searchResults;
  bool get isSearching => _isSearching;

  Future<void> searchMovies(String query) async {
    _isSearching = true;
    notifyListeners();

    try {
      _searchResults = await ApiService().searchMovies(query);
    } catch (e) {
      print(e);
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }
}
