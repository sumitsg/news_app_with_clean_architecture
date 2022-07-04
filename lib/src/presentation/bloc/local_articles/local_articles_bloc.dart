import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_with_clean_architecture/src/domain/entities/article.dart';
import 'package:news_app_with_clean_architecture/src/domain/usecase/get_saved_article_usecase.dart';
import 'package:news_app_with_clean_architecture/src/domain/usecase/remove_article_usecase.dart';
import 'package:news_app_with_clean_architecture/src/domain/usecase/save_article_usecase.dart';

part 'local_articles_event.dart';
part 'local_articles_state.dart';

class LocalArticlesBloc extends Bloc<LocalArticlesEvent, LocalArticlesState> {
  final GetSavedArticleUsecase _getSavedArticleUsecase;
  final RemoveArticleUseCase _removeArticleUseCase;
  final SavedArticleUseCases _savedArticleUseCases;

  LocalArticlesBloc(this._getSavedArticleUsecase, this._removeArticleUseCase,
      this._savedArticleUseCases)
      : super(const LocalArticlesLoading()) {
    on<GetAllSavedArticles>((event, emit) async {
      // final articles = await _getSavedArticleUsecase();
      _getAllSavedArticles();
      print("SaveArticle Called");
    });
    on<RemoveArticle>((event, emit) async {
      await _removeArticleUseCase(params: event.article);
      _getAllSavedArticles();
    });
    on<SaveArticle>((event, emit) async {
      // print(event.article);
      await _savedArticleUseCases(params: event.article);
      _getAllSavedArticles();
    });
  }

  // Stream<LocalArticlesState> mapEventToState(LocalArticlesEvent event) async* {
  //   if (event is GetAllSavedArticles) {
  //     yield* _getSavedAllArticleUsecase();
  //   }

  //   if (event is RemoveArticle) {
  //     await _removeArticleUseCase(params: event.article);
  //     yield* _getSavedAllArticleUsecase();
  //   }

  //   if (event is SaveArticle) {
  //     await _savedArticleUseCases(params: event.article);
  //     yield* _getSavedAllArticleUsecase();
  //   }
  // }

  // Stream<LocalArticlesState> _getSavedAllArticleUsecase() async* {
  //   final articles = await _getSavedArticleUsecase();
  //   yield LocalArticleDone(articles);
  // }
  void _getAllSavedArticles() async {
    final articles = await _getSavedArticleUsecase();
    // ignore: invalid_use_of_visible_for_testing_member
    emit(LocalArticleDone(articles));
  }
}
