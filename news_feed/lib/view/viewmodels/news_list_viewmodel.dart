import 'package:flutter/material.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/repository/news_repository.dart';

class NewListViewModel extends ChangeNotifier{
  final NewsRepository _repository = NewsRepository();

  SearchType _searchType = SearchType.CATEGORY;
  SearchType get searchType => _searchType;

  Category _category = categorys[0];
  Category get category => _category;  

  String _keyword = "";
  String get keyword => _keyword;  

  bool _isLoading = false;
  bool get isLoding => _isLoading;

  getNews(
    {@required SearchType searchType,String keyword,Category category}){
      //TODO
      print("serachType: $searchType /Keyword: $keyword /category: ${category.nameJp}");
    }
}