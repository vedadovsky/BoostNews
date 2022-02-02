import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/pages/homePage.dart';
import 'package:news_app/pages/search/filter/filter.dart';
import 'package:news_app/pages/search/sorting/sort.dart';

class UnderSearchBar extends StatefulWidget with PreferredSizeWidget {
  String search, from, to, sort;
  UnderSearchBar(this.search, this.sort, this.from, this.to);

  @override
  _SortByState createState() => _SortByState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SortByState extends State<UnderSearchBar> {
  @override
  Widget build(BuildContext context) {
    Widget customTitle = Image.asset(
      'images/logo.png',
      width: 70,
      height: 40,
    );
    return AppBar(
      backgroundColor: Colors.blue[900],
      centerTitle: true,
      title: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: customTitle,
      ),
      automaticallyImplyLeading: false,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Sort(widget.search, widget.from, widget.to),
        ),
      ],
      leading: Filter(widget.search, widget.sort),
    );
  }
}
