// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/src/provider/bottom_navigation_provider.dart';
import 'package:provider_test/src/provider/movie_list_provider.dart';

import 'package:provider_test/src/ui/count_home_widget.dart';
import 'package:provider_test/src/ui/movie_list_widget.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  late ButtomNavigationProvider _bottomNavigationBar;

  Widget _bottomNavigationBarWidget() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Movie',
        ),
      ],
      currentIndex: _bottomNavigationBar.currentNavigationIndex,
      selectedItemColor: Colors.amber[800],
      onTap: (index) {
        _bottomNavigationBar.updatePage(index);
        print(index);
      },
    );
  }

  Widget _navigationBody() {
    switch (_bottomNavigationBar.currentNavigationIndex) {
      case 0:
        return CountHomeWidget();

      case 1:
        return ChangeNotifierProvider<MovieListProvider>(
            create: (_) => MovieListProvider(), child: MovieList());
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    _bottomNavigationBar = Provider.of<ButtomNavigationProvider>(context);
    print("updatePage");
    return Scaffold(
      body: _navigationBody(),
      bottomNavigationBar: _bottomNavigationBarWidget(), // listen true일때
      // bottomNavigationBar: Consumer<ButtomNavigationProvider>(  // listen false 일때
      //   builder: (BuildContext context, ButtomNavigationProvider value,
      //       Widget child) {
      //     return _bottomNavigationBarWidget();
      //   },
      // ),
    );
  }
}
