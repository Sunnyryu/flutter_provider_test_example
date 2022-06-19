import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/src/provider/bottom_navigation_provider.dart';
import 'package:provider_test/src/provider/count_provider.dart';
import 'package:provider_test/src/ui/home.dart';

import 'package:provider_test/src/provider/movie_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
        ),
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (BuildContext context) => CounterProvider()),
          ChangeNotifierProvider(
              create: (BuildContext context) => ButtomNavigationProvider()),
          ChangeNotifierProvider(
              create: (BuildContext context) => MovieProvider()),
        ],
        child: Home(),
      ),
    );
  }
}
