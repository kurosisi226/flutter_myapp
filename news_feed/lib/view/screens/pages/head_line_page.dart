import 'package:flutter/material.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/models/model/news_model.dart';
import 'package:news_feed/view/components/head_line_item.dart';
import 'package:news_feed/view/components/page_transformer.dart';
import 'package:news_feed/view/viewmodels/head_line_viewmodel.dart';
import 'package:provider/provider.dart';

import 'news_web_page_screen.dart';

class HeadLinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);

    if (!viewModel.isLoding && viewModel.articles.isEmpty) {
      Future(() => viewModel.getHeadLines(searchType: SearchType.HEAD_LINE));
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<HeadLineViewModel>(
            builder: (context, model, child) {
              if (model.isLoding) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return PageTransformer(
                  pageViewBuilder: (context, pageVisibilityResoLver) {
                    return PageView.builder(
                        controller: PageController(viewportFraction: 0.85),
                        itemBuilder: (context, index) {
                          final article = model.articles[index];
                          final pageVisibility = pageVisibilityResoLver
                              .resolvePageVisibility(index);
                          final visibleFraction =
                              pageVisibility.visibleFraction;
                          return HeadLineItem(
                            article: model.articles[index],
                            pageVisibility: pageVisibility,
                            onArticleClicked: (article) =>
                                _openArticleWebPage(context, article),
                          );
                        });
                  },
                );
              }
            },
            child: Center(
              child: Text("HeadLine"),
            ),
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

  _openArticleWebPage(BuildContext context, Article article) {
    print("HeadLinePage._openArticleWebPage: ${article.url}");
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => NewsWebPageScreen(
                article: article,
              )),
    );
  }
}
