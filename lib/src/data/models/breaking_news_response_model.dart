import 'package:news_app_with_clean_architecture/src/data/models/article_model.dart';

class BreakingNewsResponseModel {
  final String? status;
  final int? totalresults;
  final List<ArticleModel>? articles;

  BreakingNewsResponseModel({this.status, this.totalresults, this.articles});

  factory BreakingNewsResponseModel.fromJson(Map<String, dynamic> json) {
    return BreakingNewsResponseModel(
        status: json['status'],
        totalresults: json['totalResults'],
        articles: List<ArticleModel>.from(
          (json['articles'] as List<dynamic>).map(
            (e) => ArticleModel.fromJson(e as Map<String, dynamic>),
          ),
        ));
  }
}
