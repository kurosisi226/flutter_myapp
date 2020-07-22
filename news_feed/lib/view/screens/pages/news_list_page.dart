import 'package:flutter/material.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/view/components/category_chips.dart';
import 'package:news_feed/view/components/search_bar.dart';
import 'package:news_feed/view/viewmodels/news_list_viewmodel.dart';
import 'package:provider/provider.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              //記事再検索
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //記事更新処理
  onRefresh(BuildContext context) {
    final viewModel = Provider.of<NewListViewModel>(context,listen:false);
    viewModel.getNews(
      searchType: viewModel.searchType,
      keyword: viewModel.keyword,
      category:viewModel.category,
    );
    print("news_list.onRefresh");
  }

  //キーワード記事取得処理
  getKeywordNews(BuildContext context, keyword) {
    final viewModel = Provider.of<NewListViewModel>(context,listen:false);
    viewModel.getNews(searchType: SearchType.KEYWORD,
    keyword: keyword,
    category: categorys[0],
    );
    print("news_list.getKeywordNews");
  }

  //カテゴリー検索
  getCategoryNews(BuildContext context, category) {
    final viewModel = Provider.of<NewListViewModel>(context,listen:false);
    viewModel.getNews(searchType: SearchType.CATEGORY,
    category: category,
    );
    print("news_list.getCategoryNews");
  }
}
