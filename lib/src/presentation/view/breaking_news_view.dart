import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:news_app_with_clean_architecture/src/core/bloc/bloc_with_state.dart';
import 'package:news_app_with_clean_architecture/src/domain/entities/article.dart';
import 'package:news_app_with_clean_architecture/src/presentation/bloc/remote_articles_bloc.dart';
import 'package:news_app_with_clean_architecture/src/presentation/bloc/remote_articles_state.dart';
import 'package:news_app_with_clean_architecture/src/presentation/widget/article_widget.dart';

class BreakingNewsView extends HookWidget {
  const BreakingNewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.addListener(
        () => _onScrollListener(context, scrollController),
      );
      [scrollController];
    });

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(scrollController),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'Daily news',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        Builder(
          builder: ((context) => GestureDetector(
                onTap: () => _onShowSavedArticleView(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Icon(
                    Ionicons.bookmark,
                    color: Colors.black,
                  ),
                ),
              )),
        ),
      ],
    );
  }

  Widget _buildBody(ScrollController scrollController) {
    return BlocBuilder<RemoteArticlesBloc, RemoteArticlesState>(
      builder: (_, state) {
        if (state is RemoteArticlesLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (state is RemoteArticlesError) {
          return const Center(
            child: Icon(Ionicons.refresh),
          );
        }
        if (state is RemoteArticlesDone) {
          return _buildArticle(
              scrollController, state.article, state.noMoreData);
        }
        return const SizedBox();
      },
    );
  }

  void _onShowSavedArticleView(BuildContext context) {
    Navigator.pushNamed(context, '/SavedArticlesView');
  }

  Widget _buildArticle(
      scrollController, List<Article>? article, bool? noMoreData) {
    return ListView(
      controller: scrollController,
      children: [
        ...List<Widget>.from(
          article!.map(
            (e) => Builder(
              builder: (context) => ArticleWidget(
                article: e,
                onArticlePressed: (e) => _onArticlePressed(context, e),
              ),
            ),
          ),
        ),
        if (noMoreData!) ...[
          const SizedBox(),
        ] else ...[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: CupertinoActivityIndicator(),
          )
        ]
      ],
    );
  }

  void _onArticlePressed(BuildContext context, Article article) {
    Navigator.pushNamed(
      context,
      '/ArticleDetailsView',
      arguments: article,
    );
  }

  void _onScrollListener(
      BuildContext context, ScrollController scrollController) {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    final remoteArticleBloc = BlocProvider.of<RemoteArticlesBloc>(context);
    final state = remoteArticleBloc.blocProcessState;

    if (currentScroll == maxScroll && state == BlocProcessState.idle) {
      remoteArticleBloc.add(const GetArticles());
    }
  }
}
