import 'package:flutter/material.dart';
import 'package:movies/UI/details/details_view.dart';
import 'package:movies/UI/home/home_view.dart';
import 'package:movies/UI/search/search_view.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => HomeView(),
        '/detailsview': (context) => DetailsView(),
        '/searchview': (context) => SearchView()
      },
    );
  }
}
