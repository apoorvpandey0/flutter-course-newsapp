import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/article.dart';
import 'package:http/http.dart' as http;

const String BASE_URL = "https://newsapi.org/v2/";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Article> articles = [];

  void getArticles() async {
    final url = Uri.parse(BASE_URL +
        "top-headlines?country=in&apiKey=c28a2ae746814b82995771ad144d96a4");
    final response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // print(response.body);
      final extData = json.decode(response.body);
      // print("Total results: ${extData['totalResults']}");
      // print("Total articles: ${extData['articles'].length}");

      for (var item in extData['articles']) {
        // Iterating over articles
        var article = Article.fromJson(item);
        // print(article);
        articles.add(article);
      }
      setState(() {});
      print("Done fetching the articles");
    } else {
      print("Could not fetch articles");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              getArticles();
            },
          ),
          body: Container(
            // Main container wrapping the listview
            color: Colors.amber,
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: articles.length == 0
                  ? Text("No articles found")

                  // Main list that shows the articles
                  : ListView.builder(
                      itemCount: articles.length,
                      // Method 1
                      // itemBuilder: (context, index) => NewsArticleWidget(),

                      // Method 2
                      itemBuilder: (context, index) {
                        // print("Index: $index");
                        return NewsArticleWidget(articles[index]);
                      },
                    ),
            ),
          ),
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
