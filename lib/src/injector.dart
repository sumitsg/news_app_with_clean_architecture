import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:news_app_with_clean_architecture/src/core/utils/constants.dart';
import 'package:news_app_with_clean_architecture/src/data/datasources/local/app_database.dart';
import 'package:news_app_with_clean_architecture/src/data/datasources/remote/news_api_service.dart';
import 'package:news_app_with_clean_architecture/src/data/repositories/articles_repository_impl.dart';
import 'package:news_app_with_clean_architecture/src/domain/repositories/articles_repository.dart';
import 'package:news_app_with_clean_architecture/src/domain/usecase/get_articles_usecases.dart';
import 'package:news_app_with_clean_architecture/src/domain/usecase/get_saved_article_usecase.dart';
import 'package:news_app_with_clean_architecture/src/domain/usecase/remove_article_usecase.dart';
import 'package:news_app_with_clean_architecture/src/domain/usecase/save_article_usecase.dart';
import 'package:news_app_with_clean_architecture/src/presentation/bloc/local_articles/local_articles_bloc.dart';
import 'package:news_app_with_clean_architecture/src/presentation/bloc/remote_articles_bloc.dart';

final injector = GetIt.instance;
Future<void> initializeDependancies() async {
  // *
  final database =
      await $FloorAppDatabase.databaseBuilder(kDatabaseName).build();
  injector.registerSingleton<AppDatabase>(database);

  injector.registerSingleton<Dio>(Dio());

  //dependancies
  injector.registerSingleton<NewsApiService>(NewsApiService(injector()));
  injector.registerSingleton<ArticleRepository>(
      ArticleRepositoryImpl(injector(), injector()));

  // Usercases
  injector.registerSingleton<GetArticleUseCase>(GetArticleUseCase(injector()));

  // *
  injector.registerSingleton<GetSavedArticleUsecase>(
      GetSavedArticleUsecase(injector()));
  injector.registerSingleton<SavedArticleUseCases>(
      SavedArticleUseCases(injector()));
  injector.registerSingleton<RemoveArticleUseCase>(
      RemoveArticleUseCase(injector()));

  // *Bloc
  injector.registerFactory<RemoteArticlesBloc>(
      () => RemoteArticlesBloc(injector()));

  injector.registerFactory<LocalArticlesBloc>(
      () => LocalArticlesBloc(injector(), injector(), injector()));
}
