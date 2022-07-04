import 'package:news_app_with_clean_architecture/src/core/params/article_request.dart';
import 'package:news_app_with_clean_architecture/src/core/resources/data_state.dart';
import 'package:news_app_with_clean_architecture/src/domain/entities/article.dart';

abstract class ArticleRepository {
  // API METHOD
  Future<DataState<List<Article>>> getBreakingNewsArticles(
    ArticleRequestParam param,
  );

  // database methods
  Future<List<Article>> getSavedArticle();

  Future<void> savedArticle(Article article);

  Future<void> removeArticle(Article article);
}
