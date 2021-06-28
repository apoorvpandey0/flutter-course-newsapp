import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_course/helpers/urls.dart';

class Article {
  // late Source source;
  late String author;
  late String title;
  late String description;
  late String url;
  late String urlToImage;
  late String publishedAt;
  late String content;

  Article(
      {
      // required this.source,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});

  Article.fromJson(Map<String, dynamic> json) {
    // Converting json to class objects
    print("INSIDE FROM JSON: $json");
    // source =
    //     (json['source'] != null ? new Source.fromJson(json['source']) : null)!;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    // Convert class objects to json
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.source != null) {
    //   data['source'] = this.source.toJson();
    // }
    data['author'] = this.author;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['urlToImage'] = this.urlToImage;
    data['publishedAt'] = this.publishedAt;
    data['content'] = this.content;
    return data;
  }
}

class Source {
  late String id;
  late String name;

  Source({required this.id, required this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ArticlesProvider with ChangeNotifier {
  List<Article> _articles = [];

  get articles => _articles;

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
      notifyListeners();
      print("Done fetching the articles");
    } else {
      print("Could not fetch articles");
    }
  }
}
