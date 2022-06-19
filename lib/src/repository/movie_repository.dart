import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider_test/src/model/movie.dart';
import 'package:http/http.dart' as http;


class MovieRepository{
  var queryParam = {'api_key': '3b5aae1d458b54b0bcb5634d69274cd1'};
  Future<List<Movie>> loadMovies() async{
    var url =  Uri.https('api.themoviedb.org', '/3/movie/popular', queryParam);
    var response = await http.get(url);
 if (response.body.isNotEmpty) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body['results'] != null) {
        List<dynamic> list = body['results'];
        print(list);
        return list.map<Movie>((item) => Movie.fromJson(item)).toList();
      }
    }
   
      return  [];
    
  }
}