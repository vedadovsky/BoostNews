import 'package:flutter/material.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/pages/news_details.dart';
import 'package:news_app/service/api_headlines.dart';

class Headlines extends StatelessWidget {
  List<News> newsList = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Possible options: ae, ar, at, au, be, bg, br, ca, ch, cn, co, cu, cz, us,
      // de, eg, fr, gb, gr, hk, hu, id, ie, il, in, it, jp, kr, lt, lv, ma, mx, ve, za
      // my, ng, nl, no, nz, ph, pl, pt, ro, rs, ru, sa, se, sg, si, sk, th, tr, tw, ua
      future: getNewsCountry('us'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (newsList.length == 0) {
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
                                      image:
                                          AssetImage("images/placeholder.png"),
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
    );
  }

  getNewsCountry(String country) async {
    newsList = await ApiHeadlines().getNewsList(country);
    return newsList;
  }
}
