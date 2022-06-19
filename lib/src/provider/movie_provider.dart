import 'package:flutter/material.dart';
import 'package:provider_test/src/model/movie.dart';
import 'package:provider_test/src/repository/movie_repository.dart';

class MovieProvider extends ChangeNotifier {
  MovieRepository _movieRepository = MovieRepository();
  List<Movie> _movies = [];

  List<Movie> get movies => _movies;
  loadMovies() async {
    List<Movie> listMovies = await _movieRepository.loadMovies();
    print(listMovies);
    print(listMovies.runtimeType);
    print("545555");
    _movies = listMovies;
    notifyListeners();
  }

  clearMovies() {
    _movies.clear();
  }
}
