import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider_test/src/model/movie.dart';

class MovieListProvider extends ChangeNotifier {
  Movie _movie = Movie(
    overview: "",
    posterPath: "",
    releaseDate: "",
    title: "",
    voteAverage: 0.1,
    voteCount: 0,
  );
  Movie get getMovie => _movie;
  updateMovie(Movie movie) {
    _movie = movie;
    notifyListeners();
  }
}
