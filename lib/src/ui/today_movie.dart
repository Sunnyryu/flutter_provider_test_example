import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/src/model/movie.dart';
import 'package:provider_test/src/provider/movie_list_provider.dart';

class TodayMovie extends StatelessWidget {
  TodayMovie({Key? key}) : super(key: key);
  // late MovieListProvider movieListProvider;

  @override
  Widget build(BuildContext context) {
    // movieListProvider = Provider.of<MovieListProvider>(context);
    // Movie movie = movieListProvider.getMovie;
    Movie movie = context.read<MovieListProvider>().getMovie;

    return Scaffold(
      appBar: AppBar(
        title: const Text("오늘의 영화"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                "123",
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
