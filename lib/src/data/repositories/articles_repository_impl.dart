import 'dart:io';

import 'package:news_app_with_clean_architecture/src/core/params/article_request.dart';
import 'package:news_app_with_clean_architecture/src/core/resources/data_state.dart';
import 'package:news_app_with_clean_architecture/src/data/datasources/local/app_database.dart';
import 'package:news_app_with_clean_architecture/src/data/datasources/remote/news_api_service.dart';
import 'package:news_app_with_clean_architecture/src/domain/entities/article.dart';
import 'package:news_app_with_clean_architecture/src/domain/repositories/articles_repository.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

class ArticleRepositoryImpl extends ArticleRepository {
  // our API service
  final NewsApiService _newsApiService;

  // our Database service
  final AppDatabase _appDatabase;

  ArticleRepositoryImpl(this._newsApiService, this._appDatabase);

  @override
  Future<DataState<List<Article>>> getBreakingNewsArticles(
      ArticleRequestParam param) async {
    try {
      final httpResponse = await _newsApiService.getBreakingNewsArticles(
          apiKey: param.apiKey,
          category: param.category,
          country: param.country,
          page: param.page,
          pageSize: param.pageSize);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.articles!);
      }
      return DataFailed(DioError(
        error: httpResponse.response.statusMessage,
        requestOptions: httpResponse.response.requestOptions,
        response: httpResponse.response,
        type: DioErrorType.response,
      ));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  // new implementation
  @override
  Future<List<Article>> getSavedArticle() async {
    return _appDatabase.articleDao.getAllArticles();
  }

  @override
  Future<void> removeArticle(Article article) async {
    return _appDatabase.articleDao.deleteArticle(article);
  }

  @override
  Future<void> savedArticle(Article article) async {
    return _appDatabase.articleDao.insertArticle(article);
  }
}
