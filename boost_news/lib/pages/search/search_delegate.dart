//Search functionality

import 'package:flutter/material.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/pages/search/search_result.dart';

class CustomSearchDelegate extends SearchDelegate {
  String sort = 'popular';
  String from, to;
  CustomSearchDelegate(this.sort, this.from, this.to, String until);
  List<News> newsList = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        color: Colors.blue[900],
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    assert(theme != null);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.brightness == Brightness.dark
            ? Colors.blue[900]
            : Colors.white,
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.blue[900]),
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
            border: InputBorder.none,
          ),
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      color: Colors.blue[900],
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    String search = query.toString();
    return Scaffold(
      body: SearchResult(search, sort, from, to),
    );

    //Search by title of that given query (Works)//

    /*  List<News> matchQuery = [];
    for (var search in newsList) {
      if (search.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(search);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return NewsDetail(
                  news: result,
                );
              },
            ));
          },
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FadeInImage(
                height: 100,
                width: 100,
                fit: BoxFit.fill,
                placeholder: const AssetImage("images/placeholder.png"),
                image: NetworkImage(result.urlToImage),
                imageErrorBuilder: (context, error, StackTrace) {
                  return const Image(
                      height: 100,
                      width: 100,
                      image: AssetImage("images/placeholder.png"));
                },
              ),
            ),
            title: Text(result.title),
            subtitle: Text(
              result.description,
              maxLines: 2,
            ),
          ),
        );
      },
    );*/
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Scaffold(
      body: SearchResult('global', 'popular', '', ''),
    );
  }
}
