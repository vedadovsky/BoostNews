import 'dart:convert';
import 'package:http/http.dart';
import 'package:news_app/model/news.dart';

class ApiEverything {
  static String URL = "https://newsapi.org/v2/everything?q=";
  getNewsList(String query) async {
    var response = await get(
        Uri.parse(URL + query + "&apiKey=c7524d2e82cf4e159563434cb315ac79"));
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
