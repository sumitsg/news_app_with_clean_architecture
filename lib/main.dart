import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_with_clean_architecture/src/configue/routes/app_routes.dart';
import 'package:news_app_with_clean_architecture/src/core/utils/constants.dart';
import 'package:news_app_with_clean_architecture/src/injector.dart';
import 'package:news_app_with_clean_architecture/src/presentation/bloc/remote_articles_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependancies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticlesBloc>(
      create: (context) => injector()..add(const GetArticles()),
      child: MaterialApp(
        title: kMaterialAppTitile,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
