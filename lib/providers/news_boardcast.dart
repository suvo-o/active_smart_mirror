import 'dart:convert';
import 'package:http/http.dart';

import 'models/article.dart';

class ArticleService {
  final String postsURL =
      "https://newsapi.org/v2/top-headlines?country=in&apiKey=8ec0d8a477834990ad38ad4b1275d78d";

  Future<List<Article>> getArticles() async {
    Response res;
    try {
      res = await get(Uri.parse(postsURL));
    } catch (e) {
      // ignore: avoid_print
      print("News Service Error");
      return [];
    }

    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      // ignore: avoid_print
      //print(body);
      List<Article> articles = [];
      body["articles"].forEach((a) {
        articles.add(Article(
            author: a["author"].toString(),
            title: a["title"].toString(),
            publishedAt: a["publishedAt"].toString()));
      });
      return articles;
    } else {
      return [
        Article(
          title: "Server Error",
          author: '',
          publishedAt: '',
        )
      ];
    }
  }
}
