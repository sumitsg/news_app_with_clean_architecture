import 'package:news_app_with_clean_architecture/src/core/params/article_request.dart';
import 'package:news_app_with_clean_architecture/src/core/resources/data_state.dart';
import 'package:news_app_with_clean_architecture/src/core/usecases/usecases.dart';
import 'package:news_app_with_clean_architecture/src/domain/entities/article.dart';
import 'package:news_app_with_clean_architecture/src/domain/repositories/articles_repository.dart';

class GetArticleUseCase
    implements UseCases<DataState<List<Article>>, ArticleRequestParam> {
  final ArticleRepository articleRepository;

  GetArticleUseCase(this.articleRepository);

  @override
  Future<DataState<List<Article>>> call({ArticleRequestParam? params}) {
    return articleRepository.getBreakingNewsArticles(params!);
  }
}
