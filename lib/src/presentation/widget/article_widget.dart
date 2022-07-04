import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:news_app_with_clean_architecture/src/domain/entities/article.dart';

class ArticleWidget extends StatelessWidget {
  final Article article;
  final bool? isRemovable;
  final void Function(Article article)? onRemove;
  final void Function(Article article)? onArticlePressed;
  const ArticleWidget(
      {Key? key,
      required this.article,
      this.isRemovable,
      this.onRemove,
      this.onArticlePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.only(
            start: 14, end: 14, bottom: 7, top: 7),
        height: MediaQuery.of(context).size.width / 2.2,
        child: Row(
          children: [
            _buildImage(context),
            _buildTitleAndDescription(),
            _buildRemovableArea(),
          ],
        ),
      ),
    );
  }

  void _onTap() {
    if (onArticlePressed != null) {
      onArticlePressed!(article);
    }
  }

  void _onRemove() {
    if (onRemove != null) {
      onRemove!(article);
    }
  }

  Widget _buildImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          height: double.maxFinite,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.08)),
          child: Image.network(
            '${article.urlToImage}',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return const Center(
                child: Text(
                  '404\nNO DATA FOUND',
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _buildTitleAndDescription() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${article.title}',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: Colors.black87),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  '${article.description}',
                  maxLines: 2,
                ),
              ),
            ),
            Row(
              children: [
                const Icon(
                  Ionicons.time_outline,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  '${article.publishAt}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRemovableArea() {
    // ignore: unrelated_type_equality_checks
    if (isRemovable ?? false) {
      return GestureDetector(
        onTap: _onRemove,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(
            Ionicons.trash_outline,
            color: Colors.red,
          ),
        ),
      );
    }
    return Container();
  }
}
