import 'package:flutter/material.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/pages/news_details.dart';
import 'package:news_app/service/api_everything.dart';

class Everything extends StatelessWidget {
  List<News> newsList = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        //Choose which topic should be displayed for everything
        future: getNewsList('bosnia'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (newsList.isEmpty) {
              return const Center(
                child: Text('No News Found'),
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
            return Center(
              child: Text(
                '${snapshot.error}',
                style: const TextStyle(fontSize: 28),
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

  getNewsList(String query) async {
    newsList = await ApiEverything().getNewsList(query);
    return newsList;
  }
}
