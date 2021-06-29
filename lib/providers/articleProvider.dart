import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_course/helpers/urls.dart';
import 'package:news_app_course/providers/article.dart';

// This is a Provider or store of data
class ArticlesProvider with ChangeNotifier {
  // This list cannot be accessed outside this class
  List<Article> _articles = [];

  bool isLoading = true;

// These both getter functions are same
  get articles => _articles;
  // get articles {
  //   return _articles;
  // }

  Future<void> getArticles() async {
    final url = Uri.parse(BASE_URL +
        "top-headlines?country=in&apiKey=c28a2ae746814b82995771ad144d96a4");
    final response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // print(response.body);
      final extData = json.decode(response.body);
      // print("Total results: ${extData['totalResults']}");
      // print("Total articles: ${extData['articles'].length}");

      for (var item in extData['articles']) {
        // // Iterating over articles
        // var article = Article.fromJson(item);

        Article article = Article(
            title: item['title'],
            content: item['content'],
            description: item['description'],
            author: item['author'] == null ? "Batman" : item['author'],
            url: item['url'],
            urlToImage:
                item['urlToImage'] == null ? "Batman" : item['urlToImage'],
            publishedAt: item['publishedAt']);
        // print(article);
        _articles.add(article);
      }
      // This notifes all the listeners of this provider to use the new/updated data
      isLoading = false;
      notifyListeners();
      print("Done fetching the articles");
    } else {
      print("Could not fetch articles");
    }
  }
}
