import 'package:flutter/material.dart';
import 'package:news_feed/models/model/news_model.dart';

class NewsWebPageScreen extends StatelessWidget {
  final Article article;

  NewsWebPageScreen({@required this.article});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(article.title),
          centerTitle: true,
        ),
        //Todo
        body: Container(),
      ),
    );
  }
}
