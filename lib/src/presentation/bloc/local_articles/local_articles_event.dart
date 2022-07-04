part of 'local_articles_bloc.dart';

abstract class LocalArticlesEvent extends Equatable {
  final Article? article;
  const LocalArticlesEvent({this.article});

  @override
  List<Object?> get props => [article];
}

// will be responsible for getting all of our saved articles.
class GetAllSavedArticles extends LocalArticlesEvent {
  const GetAllSavedArticles();
}

//  responsible for deleting a specific saved article.
class RemoveArticle extends LocalArticlesEvent {
  const RemoveArticle(Article? article) : super(article: article);
}

// responsible for inserting that article into the database.
class SaveArticle extends LocalArticlesEvent {
  const SaveArticle(Article? article) : super(article: article);
}
