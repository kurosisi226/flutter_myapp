import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/models/model/news_model.dart';
import 'package:news_feed/models/networking/api_service.dart';

class NewsRepository {
  final ApiService _apiService = ApiService.create();

  Future<List<Article>> getNews(
      {@required SearchType searchType,
      String keyword,
      Category category}) async {
    List<Article> result = List<Article>();

    Response response;

    try {
      switch (searchType) {
        case SearchType.HEAD_LINE:
          response = await _apiService.getHeadLines();
          break;
        case SearchType.KEYWORD:
          response = await _apiService.getKeywordNews(keyword: keyword);
          break;
        case SearchType.CATEGORY:
          response =
              await _apiService.getCategoryNews(category: category.nameEn);
      }
      if (response.isSuccessful) {
        final responseBody = response.body;
        print("responseBody: $responseBody");
        result = News.fromJson(responseBody).articles;
      } else {
        final errorCode = response.statusCode;
        final error = response.error;
        print("Response is not successful: $errorCode / $error");
      }
    } on Exception catch (error) {
      print("error: $error");
    }
    return result;
  }

  void dispose(){
    _apiService.dispose();
  }
}
