import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;
import 'package:flutter/material.dart';
import 'package:news_app/model/news.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetail extends StatefulWidget {
  final News news;
  const NewsDetail({Key key, this.news}) : super(key: key);

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    var pinnedHeaderHeight = statusBarHeight + kToolbarHeight;
    return Scaffold(
      body: extended.NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 200,
              title: Stack(
                children: <Widget>[
                  Text(
                    widget.news.title,
                    style: TextStyle(
                      fontSize: 20,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = Colors.black,
                    ),
                  ),
                  Text(
                    widget.news.title,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  widget.news.urlToImage,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, StackTrace) {
                    return Image(
                      fit: BoxFit.cover,
                      image: AssetImage("images/placeholder_details.png"),
                    );
                  },
                ),
              ),
            )
          ];
        },
        pinnedHeaderSliverHeightBuilder: () => pinnedHeaderHeight,
        body: SingleChildScrollView(
          child: Container(
            child: Card(
              borderOnForeground: true,
              elevation: 5,
              margin: EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.news.title ?? '',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Description:',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.news.description ?? '',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Content:',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.news.content ?? '',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      // ignore: void_checks
                      onTap: () async {
                        if (await canLaunch(widget.news.url)) {
                          await launch(widget.news.url);
                        } else {
                          return const Center(
                            child: Text(
                              'Ooops something went wrong',
                              style: TextStyle(fontSize: 28),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Read more: ' + widget.news.url ?? '',
                        style:
                            TextStyle(fontSize: 18, color: Colors.blueAccent),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
