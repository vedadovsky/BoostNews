import 'dart:convert';
import 'package:http/http.dart';
import 'package:news_app/model/news.dart';

class ApiSearch {
  static String URL = "https://newsapi.org/v2/everything?q=";
  getNewsList(String query, String sort, String from, String to) async {
    var response = await get(Uri.parse(URL +
        query +
        "&sortBy=" +
        sort +
        "&from=" +
        from +
        "&to=" +
        to +
        "&pageSize=20&apiKey=c7524d2e82cf4e159563434cb315ac79"));
    if (response.statusCode == 200) {
      List<News> newsList;
      var finalResult = json.decode(response.body);
      newsList = (finalResult['articles'] as List)
          .map((data) => News.fromJson(data))
          .toList();

      return newsList;
    } else {
      throw ('An error has occured');
    }
  }
}
