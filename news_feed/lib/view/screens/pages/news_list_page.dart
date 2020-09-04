import 'package:flutter/material.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/models/model/news_model.dart';
import 'package:news_feed/view/components/article_tile.dart';
import 'package:news_feed/view/components/category_chips.dart';
import 'package:news_feed/view/components/search_bar.dart';
import 'package:news_feed/view/screens/pages/news_web_page_screen.dart';
import 'package:news_feed/view/viewmodels/news_list_viewmodel.dart';
import 'package:provider/provider.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);

    if (!viewModel.isLoding && viewModel.articles.isEmpty) {
      Future(() => viewModel.getNews(
          searchType: SearchType.CATEGORY, category: categorys[0]));
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          tooltip: "更新",
          onPressed: () => onRefresh(context),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              //TODO検索
              SearchBar(
                onSearch: (keyword) => getKeywordNews(context, keyword),
              ),
              //カテゴリー検索
              CategoryChips(
                onCategorySelected: (category) =>
                    getCategoryNews(context, category),
              ),
              //記事表示
              Expanded(
                child: Consumer<NewsListViewModel>(
                    builder: (context, model, child) {
                  return model.isLoding
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: model.articles.length,
                          itemBuilder: (context, int position) => ArticleTile(
                                article: model.articles[position],
                                onArticleClicked: (article) =>
                                    _openArticleWebpage(article, context),
                              ));
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //記事更新処理
  onRefresh(BuildContext context) {
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
    viewModel.getNews(
      searchType: viewModel.searchType,
      keyword: viewModel.keyword,
      category: viewModel.category,
    );
    print("news_list.onRefresh");
  }

  //キーワード記事取得処理
  getKeywordNews(BuildContext context, keyword) {
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
    viewModel.getNews(
      searchType: SearchType.KEYWORD,
      keyword: keyword,
      category: categorys[0],
    );
    print("news_list.getKeywordNews");
  }

  //カテゴリー検索
  getCategoryNews(BuildContext context, category) {
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
    viewModel.getNews(
      searchType: SearchType.CATEGORY,
      category: category,
    );
    print("news_list.getCategoryNews");
  }

  //Todo
  _openArticleWebpage(Article article, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => NewsWebPageScreen(
                article: article,
              )),
    );
    print("_opneArticleWebpate: ${article.url}");
  }
}
