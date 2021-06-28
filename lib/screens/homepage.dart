import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/article.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ArticlesProvider>(context, listen: false).getArticles();
  }

  @override
  Widget build(BuildContext context) {
    // This is a listener
    final artData = Provider.of<ArticlesProvider>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Text(artData.articles[0]),
        ));
  }
}

class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          "assets/bg.jpg"
          // "https://images.pexels.com/photos/2356059/pexels-photo-2356059.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
          ,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class NewsArticleWidget extends StatelessWidget {
  final Article article;

  NewsArticleWidget(this.article);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 300,
        decoration: BoxDecoration(
          border: Border.all(
            width: 5,
          ),
          color: Colors.white,
        ),
        child: Row(
          children: [
            // Article Image
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 8, top: 8, left: 8, right: 8),
                child: Container(
                  color: Colors.green,
                  child: Image.network(article.urlToImage),
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Column(
                children: [
                  // Article Title
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.brown,
                      child: Text(article.title),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Article content
                  Expanded(
                    flex: 7,
                    child: Container(
                      color: Colors.limeAccent,
                      child: Text(article.description),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ));
  }
}
