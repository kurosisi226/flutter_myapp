import 'package:flutter/material.dart';
import 'package:news_feed/models/db/database.dart';
import 'package:news_feed/view/screens/home_screen.dart';
import 'package:news_feed/view/style/style.dart';
import 'package:news_feed/view/viewmodels/head_line_viewmodel.dart';
import 'package:news_feed/view/viewmodels/news_list_viewmodel.dart';
import 'package:provider/provider.dart';

MyDatabase myDatabase;

void main() {
  myDatabase = MyDatabase();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => NewsListViewModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => HeadLineViewModel(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NewsFeed",
      theme: ThemeData(brightness: Brightness.dark, fontFamily: BoldFont),
      home: HomeScreen(),
    );
  }
}

class Bold {}
