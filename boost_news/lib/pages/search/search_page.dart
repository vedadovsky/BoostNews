import 'package:flutter/material.dart';
import 'package:news_app/pages/search/search_delegate.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    Icon customIcon = const Icon(Icons.search);
    return IconButton(
      onPressed: () {
        showSearch(
          context: context,
          delegate: CustomSearchDelegate('', '', '', ''),
        );
      },
      icon: customIcon,
    );
  }
}
