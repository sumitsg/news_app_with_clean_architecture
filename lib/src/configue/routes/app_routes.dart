import 'package:flutter/material.dart';
import 'package:news_app_with_clean_architecture/src/domain/entities/article.dart';
import 'package:news_app_with_clean_architecture/src/presentation/view/article_details_view.dart';
import 'package:news_app_with_clean_architecture/src/presentation/view/breaking_news_view.dart';
import 'package:news_app_with_clean_architecture/src/presentation/view/saved_articles_view.dart';

class AppRoutes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(BreakingNewsView());
      case '/ArticleDetailsView':
        return _materialRoute(ArticleDetailsView(
          article: settings.arguments as Article,
        ));

      case '/SavedArticlesView':
        return _materialRoute(const SavedArticleView());

      default:
        return null;
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
