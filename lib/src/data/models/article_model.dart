import 'package:news_app_with_clean_architecture/src/data/models/source_model.dart';
import 'package:news_app_with_clean_architecture/src/domain/entities/article.dart';

class ArticleModel extends Article {
  const ArticleModel({
    int? id,
    required SourceModel source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  }) : super(
            id: id,
            source: source,
            author: author,
            title: title,
            description: description,
            url: url,
            urlToImage: urlToImage,
            publishAt: publishedAt,
            content: content);

  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
      source: SourceModel.fromJson(map['source']),
      author: map['author'],
      title: map['title'],
      description: map['description'],
      urlToImage: map['urlToImage'],
      url: map['url'],
      publishedAt: map['publishedAt'],
      content: map['content'],
    );
  }
}
