import 'package:floor/floor.dart';
import 'package:news_app_with_clean_architecture/src/core/utils/constants.dart';

import 'source.dart';
import 'package:equatable/equatable.dart';

@Entity(tableName: kArticlesTableName)
class Article extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final Source source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishAt;
  final String? content;

  const Article(
      {this.id,
      required this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishAt,
      this.content});

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        source,
        author,
        title,
        description,
        url,
        urlToImage,
        publishAt,
        content
      ];

  @override
  // TODO: implement stringify
  bool? get stringify => true;
}
