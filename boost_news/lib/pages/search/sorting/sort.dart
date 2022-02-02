import 'package:flutter/material.dart';
import 'package:news_app/pages/search/filter/filter.dart';
import 'package:news_app/pages/search/search_result.dart';

class Sort extends StatefulWidget {
  String search = 'global';
  String from, to;
  Sort(this.search, this.from, this.to);

  @override
  _SortState createState() => _SortState();
}

class _SortState extends State<Sort> {
  String date = 'publishedAt';
  String relevancy = 'relevancy';
  String popularity = 'popularity';

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (result) {
        if (result == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SearchResult(widget.search, date, widget.from, widget.to)),
          );
        } else if (result == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SearchResult(
                    widget.search, relevancy, widget.from, widget.to)),
          );
        } else if (result == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SearchResult(
                    widget.search, popularity, widget.from, widget.to)),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SearchResult(widget.search, date, widget.from, widget.to)),
          );
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Colors.blue[900],
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('Sort by Date'),
              ),
            ],
          ),
          value: 0,
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                Icons.fiber_new,
                color: Colors.blue[900],
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('Sort by Relevance'),
              )
            ],
          ),
          value: 1,
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                Icons.stars,
                color: Colors.blue[900],
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('Sort by Popularity'),
              )
            ],
          ),
          value: 2,
        ),
      ],
      child: const Icon(
        Icons.sort,
        color: Colors.white,
        size: 24,
      ),
    );
  }
}
