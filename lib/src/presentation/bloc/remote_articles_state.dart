import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:news_app_with_clean_architecture/src/domain/entities/article.dart';

abstract class RemoteArticlesState extends Equatable {
  final List<Article>? article;
  final bool? noMoreData;
  final DioError? error;
  const RemoteArticlesState({this.article, this.error, this.noMoreData});

  @override
  List<Object?> get props => [article, noMoreData, error];
}

class RemoteArticlesLoading extends RemoteArticlesState {
  const RemoteArticlesLoading();
}

class RemoteArticlesDone extends RemoteArticlesState {
  const RemoteArticlesDone(List<Article> article, {bool? noMoreData})
      : super(article: article, noMoreData: noMoreData);
}

class RemoteArticlesError extends RemoteArticlesState {
  const RemoteArticlesError(DioError error) : super(error: error);
}
