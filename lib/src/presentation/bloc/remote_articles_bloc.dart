import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:news_app_with_clean_architecture/src/core/bloc/bloc_with_state.dart';
import 'package:news_app_with_clean_architecture/src/core/params/article_request.dart';
import 'package:news_app_with_clean_architecture/src/core/resources/data_state.dart';
import 'package:news_app_with_clean_architecture/src/domain/entities/article.dart';
import 'package:news_app_with_clean_architecture/src/domain/usecase/get_articles_usecases.dart';
import 'package:news_app_with_clean_architecture/src/presentation/bloc/remote_articles_state.dart';

part 'remote_articles_event.dart';

class RemoteArticlesBloc
    extends BlocWithState<RemoteArticlesEvent, RemoteArticlesState> {
  final GetArticleUseCase getArticleUseCase;
  RemoteArticlesBloc(this.getArticleUseCase)
      : super(const RemoteArticlesLoading()) {
    final List<Article> _article = [];
    int _page = 1;
    const int pageSize = 20;

    on<GetArticles>(
      (event, emit) async {
        final dataState =
            await getArticleUseCase(params: ArticleRequestParam(page: _page));

        if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
          final article = dataState.data;
          final _noMoreData = dataState.data!.length < pageSize;
          _article.addAll(article!);
          _page++;
          emit((RemoteArticlesDone(_article, noMoreData: _noMoreData)));
        }
        if (dataState is DataFailed) {
          emit((RemoteArticlesError(dataState.error!)));
        }
      },
    );
  }
}
