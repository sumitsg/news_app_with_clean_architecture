import 'package:flutter/material.dart';
import 'package:news_app_with_clean_architecture/src/core/usecases/usecases.dart';
import 'package:news_app_with_clean_architecture/src/domain/entities/article.dart';
import 'package:news_app_with_clean_architecture/src/domain/repositories/articles_repository.dart';

class GetSavedArticleUsecase implements UseCases<List<Article>, void> {
  final ArticleRepository _articlesRepository;
  GetSavedArticleUsecase(this._articlesRepository);

  @override
  Future<List<Article>> call({void params}) {
    return _articlesRepository.getSavedArticle();
  }
}
