import 'package:news_app_with_clean_architecture/src/core/usecases/usecases.dart';
import 'package:news_app_with_clean_architecture/src/domain/entities/article.dart';
import 'package:news_app_with_clean_architecture/src/domain/repositories/articles_repository.dart';

class SavedArticleUseCases implements UseCases<void, Article> {
  final ArticleRepository _articleRepository;

  SavedArticleUseCases(this._articleRepository);

  @override
  Future<void> call({Article? params}) {
    return _articleRepository.savedArticle(params!);
  }
}
