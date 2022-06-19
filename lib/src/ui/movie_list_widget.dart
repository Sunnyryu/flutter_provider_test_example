import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider_test/src/model/movie.dart';
import 'package:provider_test/src/provider/movie_list_provider.dart';
import 'package:provider_test/src/provider/movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/src/ui/today_movie.dart';

class MovieList extends StatefulWidget {
  MovieList({Key? key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late MovieProvider _movieProvider;

  bool _visibleButton = true;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    // moveScroll();
  }

  // why don't use "ScrollDirection.idle"?????
  // void moveScroll() async {
  //   _scrollController.addListener(() {
  //     if (_scrollController.position.userScrollDirection ==
  //         ScrollDirection.forward) {
  //       showFloatButton();
  //     } else if (_scrollController.position.userScrollDirection ==
  //         ScrollDirection.reverse) {
  //       hideFloatButton();
  //     }
  //   });
  // }

  void hideFloatButton() {
    setState(() {
      _visibleButton = false;
    });
  }

  void showFloatButton() {
    setState(() {
      _visibleButton = true;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _movieProvider = Provider.of<MovieProvider>(context, listen: false);

    _movieProvider.loadMovies();
  }

  @override
  void dispose() {
    _movieProvider.clearMovies();

    _scrollController.removeListener(() {});
    super.dispose();
  }

  // scollNotification(notification) {
  //   if (notification is ScrollStartNotification ||
  //       notification is OverscrollNotification ||
  //       notification is ScrollEndNotification ||
  //       notification is ScrollUpdateNotification) {
  //     print("test1");
  //     hideFloatButton();
  //   } else if (notification is UserScrollNotification) {
  //     print("test5");
  //     showFloatButton();
  //   } else {
  //     print("test6");
  //     hideFloatButton();
  //   }
  // }
  myScrollNotification(notification) {
    if (notification is UserScrollNotification) {
      showFloatButton();
    } else {
      hideFloatButton();
    }
  }

  Widget _makeMovieOne(Movie movie) {
    return Row(
      children: [
        ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: Image.network(movie.posterUrl)),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: Text(
                    movie.overview,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13),
                    maxLines: 8,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _makeListView(List<Movie> movies) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        myScrollNotification(notification);
        return false;
      },
      child: ListView.separated(
        controller: _scrollController,
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: _makeMovieOne(movies[index]),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(height: 1);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("나름 최신 영화 DB"),
      ),
      body: Consumer<MovieProvider>(
        builder: (BuildContext context, MovieProvider value, Widget? child) {
          if (value.movies.isNotEmpty) {
            return _makeListView(value.movies);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: Visibility(
        visible: _visibleButton,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.teal,
            ),
            child: const Text("재밌는 영화 추천받기"),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TodayMovie()));
            },
          ),
        ),
      ),
    );
  }
}
