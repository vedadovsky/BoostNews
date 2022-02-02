import 'package:flutter/material.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/pages/news_details.dart';
import 'package:news_app/pages/search/underSearchBars/under_search_bar.dart';
import 'package:news_app/service/api_search.dart';

class SearchResult extends StatefulWidget {
  String search, sort, from, to;
  SearchResult(this.search, this.sort, this.from, this.to);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  List<News> newsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          UnderSearchBar(widget.search, widget.sort, widget.from, widget.to),
      body: FutureBuilder(
        future: getNewsList(widget.search, widget.sort, widget.from, widget.to),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (newsList.isEmpty) {
              return const Center(
                child: Text(
                  'No News Found',
                  style: TextStyle(fontSize: 28),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return NewsDetail(
                            news: newsList[index],
                          );
                        },
                      ));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black26,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: newsList[index].urlToImage == null
                                ? Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "images/placeholder.png"),
                                      ),
                                    ),
                                  )
                                : FadeInImage.assetNetwork(
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.fill,
                                    image: newsList[index].urlToImage,
                                    placeholder: 'images/placeholder.png',
                                    imageErrorBuilder:
                                        (context, error, StackTrace) {
                                      return const Image(
                                          height: 100,
                                          width: 100,
                                          image: AssetImage(
                                              "images/placeholder.png"));
                                    },
                                  ),
                          ),
                        ),
                        title: Text(
                          newsList[index].title ?? '',
                          maxLines: 2,
                        ),
                        subtitle: Text(
                          newsList[index].description ?? '',
                          maxLines: 2,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Please enter what you want to search',
                style: TextStyle(fontSize: 28),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  getNewsList(String query, String sort, String from, String to) async {
    newsList = await ApiSearch().getNewsList(query, sort, from, to);
    return newsList;
  }
}
