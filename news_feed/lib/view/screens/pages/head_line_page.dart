import 'package:flutter/material.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/models/model/news_model.dart';
import 'package:news_feed/view/viewmodels/head_line_viewmodel.dart';
import 'package:provider/provider.dart';

class HeadLinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);

    if (!viewModel.isLoding && viewModel.articles.isEmpty) {
      Future(() => viewModel.getHeadLines(searchType: SearchType.HEAD_LINE));
    }

    return SafeArea(
      child: Scaffold(
        body: Consumer<HeadLineViewModel>(
          builder: (context, model, child) {
            return PageView.builder(
                controller: PageController(),
                itemBuilder: (context, index) {
                  final article = model.articles[index];
                  return Container(
                      color: Colors.blueAccent,
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text(article.title),
                            Text(article.description)
                          ],
                        ),
                      ));
                });
          },
          child: Center(
            child: Text("HeadLine"),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh), //Todo 更新処理
          onPressed: () => onRefresh(context),
        ),
      ),
    );
  }

  //Todo 更新処理
  onRefresh(BuildContext context) async {
    print("Headlinepage.onRefresh.");
    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);
    await viewModel.getHeadLines(searchType: SearchType.HEAD_LINE);
  }
}
