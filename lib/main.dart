import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_course/providers/article.dart';
import 'package:provider/provider.dart';
import './screens/homepage.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ArticlesProvider(),
        ),
      ],
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
// MyApp->HomePage->DetailsPage