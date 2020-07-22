import 'package:flutter/material.dart';
import 'package:news_feed/view/screens/home_screen.dart';
import 'package:news_feed/view/style/style.dart';
import 'package:news_feed/view/viewmodels/news_list_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<NewListViewModel>(
    create: (context) => NewListViewModel(),
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