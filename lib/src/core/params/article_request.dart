import 'dart:core';

import 'package:news_app_with_clean_architecture/src/core/utils/constants.dart';

class ArticleRequestParam {
  final String apiKey;
  final String country;
  final String category;
  final int page;
  final int pageSize;

  ArticleRequestParam(
      {this.apiKey = kApiKey,
      this.country = 'us',
      this.category = 'general',
      this.page = 1,
      this.pageSize = 20});
}
